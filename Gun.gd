extends Marker2D

@export var bullet: PackedScene
@export var bullet_speed = 500

func shoot():
	#print("Shooting")
	var node = bullet.instantiate()
	node.global_position = global_position
	node.linear_velocity = Vector2(bullet_speed, 0).rotated(global_rotation)
	$/root/Node2D.add_child(node)
