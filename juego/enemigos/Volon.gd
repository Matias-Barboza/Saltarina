extends Area2D


#onready var animacion = $AnimatedSprite
onready var detector_jugador = $DetectorJugador
onready var detector_pisoton = $DetectorPisoton/Colisionador
onready var animacion = $AnimationPlayer


func _on_DetectorPisoton_body_entered(body):
	desactivar_colisionadores([detector_jugador, detector_pisoton])
	#Como ya estará ejecutando la animacion de volar, primero paro esa animacion
	animacion.stop()
	animacion.play("morir")
	body.impulsar()


func desactivar_colisionadores(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("visible", false)
		colision.set_deferred("disabled", true)


func _on_body_entered(body):
	body.respawn()
