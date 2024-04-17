extends Node2D


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("restart") and $Clock/Label/HTTPRequest.get_http_client_status() == HTTPClient.STATUS_DISCONNECTED:
		get_tree().paused = false
		get_tree().reload_current_scene()
	if event.is_action_pressed("quit") and $Clock/Label/HTTPRequest.get_http_client_status() == HTTPClient.STATUS_DISCONNECTED:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://main_menu.tscn")
