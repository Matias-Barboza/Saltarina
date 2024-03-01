extends StaticBody2D


onready var animacion = $AnimationPlayer
onready var sonido_salto = $AudioStreamPlayer


func _ready():
	animacion.play("idle")


func _on_DetectorImpulso_body_entered(body):
	body.impulsar()
	sonido_salto.play()
	animacion.play("Impulso")
