extends Area2D


export var proximo_nivel = ""


var esta_activado = false


func _ready():
# warning-ignore:return_value_discarded
	get_parent().connect("abrir_portal", self, "activar")

func _on_body_entered(body):
	if esta_activado:
		body.activar_animacion_entrar_portal(global_position)
		yield(get_tree().create_timer(1.5), "timeout")
		cambiar_nivel()

func cambiar_nivel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(proximo_nivel)

func activar():
	esta_activado = true
	$AnimationPlayer.play("Activado")
