extends Line2D

@export var target_shield = false

func _ready():
	$RayCast2D.target_position = $"..".linear_velocity * 5000
	$RayCast2D.force_raycast_update()

func _physics_process(delta):
	#global_rotation = $"..".linear_velocity.angle()
	$RayCast2D.target_position = to_local($"..".linear_velocity * 5000)
	points[1] = to_local($RayCast2D.get_collision_point())
	if $RayCast2D.get_collider() != null and ["Player", "Shield" if target_shield else "None"].has($RayCast2D.get_collider().name):
		visible = true
	else:
		visible = false
