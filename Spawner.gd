extends Marker2D

@export var item: PackedScene
var portal = preload("res://portal.tscn")
@export var portal_texture: SpriteFrames
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
		

	var portal_effect = portal.instantiate()
	portal_effect.global_position = spawn_loc
	portal_effect.sprite_frames = portal_texture
	$/root/Node2D.add_child(portal_effect)
	await get_tree().create_timer(0.6).timeout
	var node = item.instantiate()
	node.global_position = spawn_loc
	node.rotation_degrees = 360 * randf()
	$/root/Node2D.add_child(node)
