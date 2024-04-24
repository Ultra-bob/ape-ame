extends Node2D

var riangle = preload("res://riangle.tscn")

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
		tween.tween_property(node, "position", Vector2.ZERO, 1)
