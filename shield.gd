extends Node2D

#! egregious code

func find_collisionshape():
	if get_parent().name == "ShieldMarker":
		return get_parent().get_parent().get_node("CollisionShape2D")
	elif get_parent().has_node("CollisionShape2D"):
		return get_parent().get_node("CollisionShape2D")
	return null

func _ready() -> void:
	if find_collisionshape():
		print(find_collisionshape().get_parent().name)
		find_collisionshape().set_deferred("disabled", true)
	$Collider.set_deferred("disabled", false)

func destroy():
	if find_collisionshape():
		find_collisionshape().set_deferred("disabled", false)
	$AnimatedSprite2D.play("die")
