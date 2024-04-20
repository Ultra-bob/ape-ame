extends Marker2D

@export var item: PackedScene
@export var random_off_screen = false
@export var radius = 100

func spawn():
	if get_tree().paused:
		return
	var spawn_loc = Vector2.ZERO
	if random_off_screen:
		var random = randi_range(1, 4)
		if random == 1:
			spawn_loc = Vector2(-50, 1080 * randf())
		elif random == 2:
			spawn_loc = Vector2(1950, 1080 * randf())
		elif random == 3:
			spawn_loc = Vector2(1920 * randf(), -50)
		elif random == 4:
			spawn_loc = Vector2(1920 * randf(), 1080 + 50)
	for i in range(10):
		var test_pos = Vector2(randf(), randf()) * Vector2(1920, 1080)
		if not $"../CollisionCheck".is_clear(test_pos, radius):
			continue
		spawn_loc = test_pos
		break
		

	var node = item.instantiate()
	node.global_position = spawn_loc
	node.rotation_degrees = 360 * randf()
	print(node.global_position)
	$/root/Node2D.add_child(node)
