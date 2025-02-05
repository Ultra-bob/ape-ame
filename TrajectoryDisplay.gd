extends Line2D

@export var target_shield = false

func _ready():
	$ShapeCast2D.target_position = $"..".linear_velocity * 1000
	$ShapeCast2D.force_shapecast_update()

func _physics_process(delta):
	#global_rotation = $"..".linear_velocity.angle()
	$ShapeCast2D.target_position = to_local($"..".linear_velocity * 1000)
	points[1] = to_local($ShapeCast2D.get_collision_point(0))
	if $ShapeCast2D.get_collider(0) != null and ["Player", "Shield" if target_shield else "None"].has($ShapeCast2D.get_collider(0).name):
		visible = true
	else:
		visible = false
