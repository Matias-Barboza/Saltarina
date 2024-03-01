extends Control


export var nivel_inicial = ""


func _ready():
	DatosPlayer.reset()


func _on_ButtonIniciarJuego_pressed():
# warning-ignore:return_value_discarded
	MusicaGlobal.replay()
	get_tree().change_scene(nivel_inicial)
