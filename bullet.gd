extends RigidBody2D

var bounces = 0
@onready var player = $"../Player"

func _physics_process(delta):
	rotation = linear_velocity.angle()
	#if linear_velocity.length() < 1100:
	#	apply_central_force((global_position - player.global_position).normalized() * -200)

func hit(body):	
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			var explosion = load("res://explosion.tscn").instantiate()
			$"/root/Node2D".add_child(explosion)
			explosion.global_position = global_position
			body.queue_free()
			
		queue_free()
	else:
		bounces += 1
		$Sprite2D.play("depleted")
		#print(bounces)

	if bounces >= 2:
		queue_free()
