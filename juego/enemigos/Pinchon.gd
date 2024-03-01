extends KinematicBody2D


export var velocidad = 100.0


var gravedad = 800.0
var movimiento = Vector2.ZERO


onready var animacion = $AnimatedSprite
onready var detectorVacio = $DetectorVacio
onready var detectorPared = $DetectorPared


func _physics_process(_delta):
	
	caer()
	caminar()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)


func caer():
	if not is_on_floor():
		movimiento.y = gravedad


func caminar():
	if not animacion.is_playing():
		animacion.play("caminar")
	
	detectar_colision()
	
	movimiento.x = velocidad


func rotar_animacion():
	animacion.flip_h = not animacion.flip_h


func detectar_colision():
	if not detectorVacio.is_colliding() or detectorPared.is_colliding():
		velocidad *= -1
		rotar_animacion()
		detectorVacio.position *= -1
		detectorPared.scale *= -1
		detectorPared.position.x *= -1


func _on_body_entered(body):
	body.respawn()
