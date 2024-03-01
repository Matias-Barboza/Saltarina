extends Control


func mostrar():
	visible = true
	get_tree().paused = true


func _input(event):
	if not event.is_action_pressed("pausar") and not event is InputEventMouseMotion:
		visible = false
		get_tree().paused = false
