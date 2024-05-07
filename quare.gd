extends StaticBody2D

func destroy():
	if not is_queued_for_deletion():
		var explosion = load("res://explosion.tscn").instantiate()
		$"/root/Node2D".add_child(explosion)
		explosion.global_position = global_position
		await get_tree().create_timer(0.2).timeout
		$"../Player".aquire_quare()
		queue_free()
