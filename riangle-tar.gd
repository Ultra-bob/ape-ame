extends RigidBody2D

@onready var player = $"/root/Node2D/Player"
var dying = false

func destroy():
	if dying:
		return
	dying = true
	var explosion = load("res://explosion.tscn").instantiate()
	$"/root/Node2D".add_child(explosion)
	explosion.global_position = global_position
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _physics_process(delta):
	apply_central_force((global_position - player.global_position).normalized() * -100)
	
	$ExplosionRadius.visible = false
	for body in $Explosion.get_overlapping_bodies():
		if body.name == "Player":
			$ExplosionRadius.visible = true

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
	#print(body.name)
	if body.name == "Player":
		$Sprite2D.play("default")
		$ExplosionRadius.blink()
		get_tree().create_tween().tween_property($ExplosionRadius/Timer, "wait_time", 0.05, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		$ExplosionRadius.visible = true
