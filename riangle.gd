extends PhysicsBody2D

func destroy():
	var explosion = load("res://explosion.tscn").instantiate()
	$"/root/Node2D".add_child(explosion)
	explosion.global_position = global_position
	await get_tree().create_timer(0.2).timeout
	queue_free()
