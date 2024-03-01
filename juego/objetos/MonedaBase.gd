extends Area2D


export(String, "oro","plata","bronce") var tipo_moneda


onready var animacion = $AnimatedSprite
onready var animation_player = $AnimationPlayer
onready var colision = $CollisionShape2D


func _ready():
	animacion.play()


func _on_body_entered(_body):
	DatosPlayer.sumar_moneda(tipo_moneda)
	colision.set_deferred("disabled", true)
	animation_player.play("consumida")
