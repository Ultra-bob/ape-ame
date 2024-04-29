extends RigidBody2D

var phase2_active = false
var health = 10
var spawn_remaining = 5
@onready var player = $"../Player"

func hit(body):
	if body.is_in_group("destructible"):
		if body.has_method("destroy"):
			body.destroy()
		else:
			body.queue_free()
		health -= 1
	if body.name == "Border":
		health -= 1
		
	if health <= 0 and not is_queued_for_deletion():
		# do the death stuff
		queue_free()

func _ready():
	await get_tree().create_timer(1).timeout
	phase()
	
func _physics_process(delta):
	if phase2_active:
		apply_central_force((global_position - player.global_position).normalized() * -1700)

func phase():
	if phase2_active:
		return
	if spawn_remaining <= 0:
		phase2()
		return
	
	spawn_remaining -= 1
	$Sprite.play("spawn")
	$"Riangle Zone".spawn()
	await get_tree().create_timer(1).timeout
	$Sprite.play("idle")
	$"Riangle Zone".eject()

func phase2():
	$Sprite.play("transform")
	await $Sprite.animation_finished
	$Sprite.play("phase2")
	phase2_active = true
	freeze = false
