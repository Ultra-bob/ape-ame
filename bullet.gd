extends RigidBody2D

var bounces = 0
@onready var player = $"../Player"

func _physics_process(delta):
	apply_central_force((global_position - player.global_position).normalized() * -50)
	if linear_velocity.length() < 10:
		$Sprite2D.play("default")
	
	if player in $Explosion.get_overlapping_bodies():
		$Sprite2D.play("default")
	
func explode():
	for item in $Explosion.get_overlapping_bodies():
		hit(item)
	queue_free()

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
