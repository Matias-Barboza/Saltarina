extends Area2D

export var recorrido_invertido: bool

func _ready():
	if recorrido_invertido:
		 $AnimationPlayer.play("desplazar (invertido)")

func _on_body_entered(body):
	body.respawn()
