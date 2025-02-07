extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		visible = not visible
		if get_tree().paused:
			get_parent().paused.emit()
		else:
			get_parent().unpaused.emit()
		
