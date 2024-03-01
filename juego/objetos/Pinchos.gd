extends Area2D


export var es_trampa = false


var color_trampa = Color.blueviolet


onready var detector_personaje = $DetectorPersonaje


func _ready():
	if es_trampa:
		detector_personaje.enabled = true
		rotation_degrees = 180
		$Sprite.modulate = color_trampa


func _process(_delta):
	if detector_personaje.is_colliding():
		detector_personaje.set_deferred("enabled", false)
		$AnimationPlayer.play("Caer")


func _on_body_entered(body):
	body.respawn()
