extends Node2D


export var rayo : PackedScene


var puede_disparar = true


onready var detector_jugador = $Sprite/RayCast2D
onready var posiciones_disparos = $Sprite/PosicionesDisparos
onready var sfx_rayos = $AudioStreamPlayer

#Esta es una forma de traer el rayo
#onready var rayo = "res://juego/objetos/Rayo.tscn"


func _process(_delta):
	if detector_jugador.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = not puede_disparar
		$Timer.start()


func disparar():
	instanciar_rayos()


func instanciar_rayos():
	sfx_rayos.play()
	for posicion in posiciones_disparos.get_children():
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		#add.child(nuevo_rayo) --> crea los rayos por debajo de cada instancia de nubon
		#sirve para ordenar e instanciar todos los rayos en un nodo determinado de la escena nivel1
		owner.get_node("Rayos").add_child(nuevo_rayo)


func _on_Timer_timeout():
	puede_disparar = not puede_disparar
