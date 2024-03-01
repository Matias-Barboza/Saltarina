extends Control

export var menu_principal = ""

func _ready():
	visible = false
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("pausar"):
		visible = not visible
		get_tree().paused = not get_tree().paused


func _on_ButtonContinuar_pressed():
	visible = false
	get_tree().paused = false

func _on_ButtonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_principal)
