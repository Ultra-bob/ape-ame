extends RigidBody2D

@onready var player = $"../Player"

func hit(body):
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
			spawn_explosion()
		queue_free()
	if body.name == "Border":
		queue_free()
		spawn_explosion()
		
func spawn_explosion():
	var explosion = load("res://explosion.tscn").instantiate()
	$"/root/Node2D".add_child(explosion)
	explosion.global_position = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	apply_central_force((global_position - (player.global_position + player.linear_velocity * 3)).normalized() * -1200)
