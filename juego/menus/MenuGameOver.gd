extends Control


export var menu_principal = ""
var nivel_actual = ""


func _ready():
	nivel_actual = DatosPlayer.nivel_actual
	DatosPlayer.reset()


func _on_ButtonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_principal)


func _on_ButtonReintentarNivel_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)
