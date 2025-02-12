extends Line2D

@export var target_shield = false

const PLAY_AREA = Rect2(0, 0, 1920, 1080)

@onready var player = $"/root/Node2D/Player"

func _physics_process(delta):
	#global_rotation = $"..".linear_velocity.angle()
	
	var poi = Geometry2D.segment_intersects_segment(player.global_position, player.global_position + player.linear_velocity, global_position, global_position + get_parent().linear_velocity)

	if poi != null and PLAY_AREA.has_point(poi):
		set_point_position(1, Vector2.RIGHT * 1000)
		visible = true
	else:
		visible = false
		
	#queue_redraw()

#func _draw() -> void:
#
	#draw_line(Vector2.ZERO, to_local(global_position + get_parent().linear_velocity), Color.RED)
