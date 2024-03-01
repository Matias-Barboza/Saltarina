extends Control


export var menu_principal = ""


func _ready():
	$Panel2/Label.text = "Tu puntaje: {puntaje}".format({"puntaje":DatosPlayer.generar_puntaje()})
	


func _on_ButtonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_principal)
