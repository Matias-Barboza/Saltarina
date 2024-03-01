extends Area2D


onready var animacion = $AnimationPlayer
onready var detector_body = $CollisionShape2D


func _on_body_entered(body):
	aplicar_powerUp(body)
	detector_body.set_deferred("disabled", true)
	animacion.play("Consumir")


# warning-ignore:unused_argument
func aplicar_powerUp(body):
	pass
