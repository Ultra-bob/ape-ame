extends Node2D

var target: Node2D

func _process(delta):
	if target:
		look_at(target.global_position + target.linear_velocity)
