extends "res://riangle.gd"

@onready var player = $"../Player"

func _physics_process(delta):
	apply_central_force((global_position - player.global_position).normalized() * -50)

func hit(body):	
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
			
		queue_free()

		
func explode():
	for body in $Explosion.get_overlapping_bodies():
		hit(body)
		
	queue_free()


func _on_explosion_body_entered(body):
	if body.name == "Player":
		$Sprite2D.play("default")
		$ExplosionRadius.visible = true
