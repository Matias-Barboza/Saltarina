extends KinematicBody2D

signal activar_animacion_recarga_dash

export var velocidad = Vector2(150.0, 150.0)
export var acel_caida = 400
export var fuerza_salto = 2500
export var fuerza_rebote = 350
export var impulso = -3700
export var impulso_dash = 3600


var movimiento = Vector2.ZERO
var fuerza_salto_original
var aceleracion_caida_original
var velocidad_original
var puede_moverse = true
var puede_caer = true
var puede_dash = true
var vidas = 3


# Sirve para referenciar a una animacion
onready var animacion = $AnimatedSprite
onready var audioSalto = $AudioSalto
onready var camara = $Camera2D
onready var timerSalto = $EnfriadorSalto
onready var timerVolar = $EnfriamientoVolar
onready var animation_player = $AnimationPlayer
onready var enfriamiento_recarga_dash = $EnfriadorRecargaDash
onready var enfriador_dash = $EnfriadorDash


func _ready():
	fuerza_salto_original = fuerza_salto
	aceleracion_caida_original = acel_caida
	velocidad_original = velocidad
	animation_player.play("Aclarar")


func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	
	caida()
	saltar()
	colision_techo()
	caida_al_vacio()
	dash()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)



func tomar_direccion():
	var direccion = 0
	
	if puede_moverse:
		direccion = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
		if direccion == 0:
			animacion.play("Idle")
		elif direccion != 0:
			animacion.flip_h = true if direccion < 0 else false
			animacion.play("Correr")
	
	
	return direccion


func caida():
	if not is_on_floor() and puede_caer:
		animacion.play("Saltar")
		movimiento.y += acel_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)


func saltar():
	if Input.is_action_just_pressed("salto") and is_on_floor() and puede_moverse:
		audioSalto.play()
		animacion.play("Saltar")
		saltar_movimiento()


func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto


func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote


func respawn():
	DatosPlayer.restar_vidas()
	animation_player.play("Oscurecer")
	if(DatosPlayer.vidas != 0):
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


func caida_al_vacio():
	if position.y > camara.limit_bottom:
		respawn()


func impulsar():
	movimiento.y = impulso


func cambiar_fuerza_salto():
	timerSalto.start()
	fuerza_salto = -impulso * 0.9


func volar():
	timerVolar.start()
	acel_caida = 60
	animation_player.play("Volar")
	saltar_movimiento()


func dash():
	if Input.is_action_just_pressed("dash") and puede_dash and tomar_direccion() != 0:
		$Particles2D.get_process_material().gravity.x = 100.0 if tomar_direccion() < 0 else -100.0
		animation_player.play("dash")
		puede_dash = false
		puede_caer = false
		enfriamiento_recarga_dash.start()
		enfriador_dash.start()
		emit_signal("activar_animacion_recarga_dash")
		
		velocidad.x = impulso_dash
		velocidad.x = lerp(velocidad.x, 0.0, 0.5)
		movimiento.y = 0


func _on_EnfriadorSalto_timeout():
	fuerza_salto = fuerza_salto_original


func _on_EnfriamientoVolar_timeout():
	animation_player.play("Idle")
	acel_caida = aceleracion_caida_original


func _on_EnfriadorDash_timeout():
	puede_caer = true
	velocidad = velocidad_original


func _on_EnfriadorRecargaDash_timeout():
	puede_dash = true


func activar_animacion_entrar_portal(posicion_portal):
	puede_moverse = false
	animation_player.play("Entrar_Portal")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Entrar_Portal":
		animation_player.play("Oscurecer")


#func _process(delta):
	#Si no queremos mapear una serie de teclas para una accion, podemos realizar con cada tecla que queramos
	# pressed = mientras sea presionado
	# just pressed = solo una vez cuando presiono la tecla o mantengo presionado
	# just released = solo ejecuta cuando suelto la tecla presionada
#	if(Input.is_action_pressed("salto")):
#		print("saltando")
