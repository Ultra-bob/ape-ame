extends Node2D

@export var waves: Array[Wave]
@export var wave_label: Label
var portal = preload("res://portal.tscn")
var enemies_previous = false
var wave_count = 0

func _ready():
	spawn_loop()
	
signal all_enemies_perished

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
		if wave.wait_for_killed:
			await all_enemies_perished
		else:
			await get_tree().create_timer(wave.spawning_duration).timeout
		await get_tree().create_timer(wave.wait).timeout
		
	$"../GameOver".text = "YOU WIN!"
	$"../Player".destroy()
		
func spawn_enemies(count: int, duration: float, enemy: WaveEnemy):
	var delay = duration / count
	for i in range(count):
		await get_tree().create_timer(delay).timeout
		spawn(enemy)

func spawn(item: WaveEnemy):

	var spawn_loc = Vector2.ZERO

	for i in range(10):
		var test_pos = Vector2(randf(), randf()) * Vector2(1920, 1080)
		if not $"../CollisionCheck".is_clear(test_pos, item.check_distance):
			continue
		spawn_loc = test_pos
		break
	
	var portal_effect = portal.instantiate()
	portal_effect.global_position = spawn_loc
	portal_effect.sprite_frames = item.portal_texture
	$/root/Node2D.add_child(portal_effect)
	await get_tree().create_timer(0.6).timeout
	var node = item.enemy.instantiate()
	node.global_position = spawn_loc
	node.rotation_degrees = 360 * randf()
	$/root/Node2D.add_child(node)
