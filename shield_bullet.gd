extends RigidBody2D

@onready var player = $"../Player"

var shield_scene = preload("res://shield.tscn")
var player_shield = preload("res://player-shield.tscn")

func _physics_process(delta):
	rotation = linear_velocity.angle()
	#if linear_velocity.length() < 1100:
	#	apply_central_force((global_position - player.global_position).normalized() * -200)

func hit(body):	
	if body.is_in_group("destructible") and body.name != "Shield":
		
		var shield = shield_scene.instantiate()
		
		if body.has_node("Shield"):
			queue_free()
			return
		
		if body.name == "Player":
			shield = player_shield.instantiate()
			var marker = body.get_node("ShieldMarker")
			
			shield.position = marker.position
			shield.scale = marker.scale
			
			body.add_child(shield)
		
		elif body.has_node("ShieldMarker"):
			if body.get_node("ShieldMarker").has_node("Shield"):
				queue_free()
				return
			shield.scale = Vector2.ONE
			body.get_node("ShieldMarker").add_child(shield)
		else:
			body.add_child(shield)
			
		shield.position = Vector2.ZERO
			
		queue_free()

	else:
		queue_free()
