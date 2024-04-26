extends Node2D

var riangle = preload("res://riangle-tar.tscn")

func spawn():
	process_mode = Node.PROCESS_MODE_DISABLED
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	for zone in get_children():
		var node = riangle.instantiate()
		zone.add_child(node)
		node.global_rotation = zone.global_rotation
		node.global_position = global_position
		tween.tween_property(node, "position", Vector2.ZERO, 0.5)

func eject():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	for spawner in get_children():
		var riangle = spawner.get_child(0)
		tween.tween_property(riangle, "position", Vector2(randi_range(200, 400), 0), 0.5)
		tween.tween_property(spawner, "process_mode", PROCESS_MODE_PAUSABLE, 0.1)
		
	await tween.finished
	await get_tree().create_timer(1).timeout
	
	for spawner in get_children():
		spawner.process_mode = Node.PROCESS_MODE_INHERIT
