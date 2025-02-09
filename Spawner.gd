extends Node2D

@export var waves: Array[Wave]
@export var wave_label: Label
var portal = preload("res://portal.tscn")
var enemies_previous = false
@export var start_wave = 0
var wave_count = start_wave

func _ready():
	if start_wave != 0:
		await get_tree().create_timer(2).timeout
	waves = waves.slice(start_wave)
	spawn_loop()
	
signal all_enemies_perished
signal wave_complete

func check_enemies_loop():
	var has_enemies = len(get_tree().get_nodes_in_group("enemy")) > 0
	if enemies_previous and not has_enemies:
		all_enemies_perished.emit()
	enemies_previous = has_enemies

func spawn_loop():
	for wave in waves:
		wave_count += 1
		wave_label.text = "Wave %d" % wave_count
		print("Starting Next Wave")
		for i in range(len(wave.enemies)):
			spawn_enemies(wave.quantities[i], wave.spawning_duration, wave.enemies[i])
		await get_tree().create_timer(wave.spawning_duration).timeout
		if wave.wait_for_killed:
			enemies_previous = true
			await all_enemies_perished
			print("all enemies perished")
		await get_tree().create_timer(wave.wait).timeout
		wave_complete.emit()
		
		
	wave_count += 1
	$"../GameOver".text = "YOU WIN!"
	$"../Player".destroy()
		
func spawn_enemies(count: int, duration: float, enemy: WaveEnemy):
	var delay = duration / count
	for i in range(count):
		if get_tree().paused:
			await get_parent().unpaused
		spawn(enemy)
		await get_tree().create_timer(delay).timeout

func spawn(item: WaveEnemy):

	var spawn_loc = Vector2.ZERO

	if item.boss:
		print("Spawning Boss!")
		spawn_loc = Vector2(1920/2, 1080/2)
	else:
		for i in range(1000):
			var test_pos = Vector2(randf(), randf()) * Vector2(1920, 1080)
			if not $"../CollisionCheck".is_clear(test_pos, item.check_distance):
				continue
			if Geometry2D.segment_intersects_circle($"../Player".global_position, $"../Player".global_position + $"../Player".linear_velocity, test_pos, 250) != -1:
				continue
			spawn_loc = test_pos
			break
			
	if spawn_loc == Vector2.ZERO:
		print("Error! Failed to spawn enemy")
		return
	
	if not item.boss:
		var portal_effect = portal.instantiate()
		portal_effect.global_position = spawn_loc
		portal_effect.sprite_frames = item.portal_texture
		$/root/Node2D.add_child.call_deferred(portal_effect)
		await get_tree().create_timer((item.portal_texture.get_frame_count("default") / 2) * (1 / item.portal_texture.get_animation_speed("default"))).timeout
	var node = item.enemy.instantiate()
	node.global_position = spawn_loc
	if not item.boss:
		node.rotation_degrees = 360 * randf()
	$/root/Node2D.add_child(node)
