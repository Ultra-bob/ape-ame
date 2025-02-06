extends Node2D

var target: Node2D

func _process(delta):
	if target and is_instance_valid(target):
		if target.is_class("RigidBody2D"):
			look_at(target.global_position + target.linear_velocity)
		else:
			look_at(target.global_position)
