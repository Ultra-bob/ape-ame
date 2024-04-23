extends Marker2D

@export var item: PackedScene
var portal = preload("res://portal.tscn")
@export var portal_texture: SpriteFrames
@export var random_off_screen = false
@export var radius = 100

func project_ray_to_screen_edge(player_position: Vector2) -> Vector2:
	var screen_size = get_viewport().size
	
	# Generate a random point on the screen
	var random_point = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.y))
	
	# Calculate the direction vector from the player to the random point
	var direction = (random_point - player_position).normalized()
	
	# Calculate the intersection points with the screen edges
	var intersection_points = []
	
	# Check intersection with the left edge
	var left_intersection = Vector2(0, player_position.y + direction.y * (0 - player_position.x) / direction.x)
	if left_intersection.y >= 0 and left_intersection.y <= screen_size.y:
		intersection_points.append(left_intersection)
	
	# Check intersection with the right edge
	var right_intersection = Vector2(screen_size.x, player_position.y + direction.y * (screen_size.x - player_position.x) / direction.x)
	if right_intersection.y >= 0 and right_intersection.y <= screen_size.y:
		intersection_points.append(right_intersection)
	
	# Check intersection with the top edge
	var top_intersection = Vector2(player_position.x + direction.x * (0 - player_position.y) / direction.y, 0)
	if top_intersection.x >= 0 and top_intersection.x <= screen_size.x:
		intersection_points.append(top_intersection)
	
	# Check intersection with the bottom edge
	var bottom_intersection = Vector2(player_position.x + direction.x * (screen_size.y - player_position.y) / direction.y, screen_size.y)
	if bottom_intersection.x >= 0 and bottom_intersection.x <= screen_size.x:
		intersection_points.append(bottom_intersection)
	
	# Find the closest intersection point to the player
	var closest_intersection = intersection_points[0]
	var min_distance = player_position.distance_to(closest_intersection)
	for point in intersection_points:
		var distance = player_position.distance_to(point)
		if distance < min_distance:
			closest_intersection = point
			min_distance = distance
	
	return closest_intersection

func spawn():
	if get_tree().paused:
		return
	var spawn_loc = Vector2.ZERO
	if random_off_screen:
		spawn_loc = project_ray_to_screen_edge($"../Player".global_position)
		#print(spawn_loc)
	for i in range(10):
		var test_pos = Vector2(randf(), randf()) * Vector2(1920, 1080)
		if not $"../CollisionCheck".is_clear(test_pos, radius):
			continue
		spawn_loc = test_pos
		break
		
	
	if spawn_loc != Vector2.ZERO:
		var portal_effect = portal.instantiate()
		portal_effect.global_position = spawn_loc
		portal_effect.sprite_frames = portal_texture
		$/root/Node2D.add_child(portal_effect)
		await get_tree().create_timer(0.6).timeout
		var node = item.instantiate()
		node.global_position = spawn_loc
		node.rotation_degrees = 360 * randf()
		$/root/Node2D.add_child(node)
