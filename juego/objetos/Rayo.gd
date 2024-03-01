extends Area2D


export var velocidad = 400.0


var mi_pos = Vector2.ZERO


onready var animacion = $AnimatedSprite


func _ready():
	global_position = mi_pos
	animacion.play("caer")


func _process(delta):
	global_position.y += velocidad * delta


func _on_VisibilityNotifier2D_screen_exited():
	destruirse()


func crear(posicion):
	mi_pos = posicion


func destruirse():
	queue_free()


func _on_body_entered(body):
	if body.name == "Saltarina":
		body.respawn()
	
	destruirse()
