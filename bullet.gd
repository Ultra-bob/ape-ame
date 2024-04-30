extends RigidBody2D

var bounces = 0
@onready var player = $"../Player"

func _physics_process(delta):
	rotation = linear_velocity.angle()

func hit(body):	
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
			
		queue_free()
	else:
		bounces += 1
		#print(bounces)

	if bounces >= 2:
		queue_free()
