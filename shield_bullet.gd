extends RigidBody2D

@onready var player = $"../Player"

var shield_scene = preload("res://shield.tscn")

func _physics_process(delta):
	rotation = linear_velocity.angle()
	#if linear_velocity.length() < 1100:
	#	apply_central_force((global_position - player.global_position).normalized() * -200)

func hit(body):	
	if body.is_in_group("destructible") and body.name != "Shield":
		
		var shield = shield_scene.instantiate()
		
		
		if body.has_node("ShieldMarker"):
			shield.scale = Vector2.ONE
			body.get_node("ShieldMarker").add_child(shield)
		else:
			body.add_child(shield)
			
		shield.position = Vector2.ZERO
			
		queue_free()

	else:
		queue_free()
