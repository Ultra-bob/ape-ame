extends Node2D

var riangle = preload("res://riangle-tar.tscn")

func spawn():
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
	for spawner in get_children():
		var riangle = spawner.get_child(0)
		if riangle == null:
			return
		riangle.apply_central_impulse(Vector2(1000, randi_range(-100, 100)).rotated(spawner.rotation))
		await get_tree().create_timer(0.05).timeout
		riangle.reparent($/root/Node2D)
		
	await get_tree().create_timer(0.1).timeout
