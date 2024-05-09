extends "res://player.gd"

var num_quares = 0
var max_quares = 3
var exagons = 0

var quare_ability = preload("res://quare_ability.tscn")

func update_animation():
	if moving:
		$AnimatedSprite2D.play("moving")
	else:
		$AnimatedSprite2D.play("idle")

func _ready():
	for i in range(max_quares):
		$"../".get_node("%Ability").add_child(quare_ability.instantiate())
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")

func _input(event):
	if event.is_action_pressed("quare"):
		if num_quares >= max_quares:
			notifier.notify("All Quares in Use!")
			return
		for child in $"../".get_node("%Ability").get_children():
			if child.value == 0 and not child.animating:
				child.value = 100
				break
		if not $"../CollisionCheck".is_clear(get_global_mouse_position(), 60):
			$"../CollisionCheck".flash()
			notifier.notify("Too Close!")
			return
		num_quares += 1
		var new_quare = quare.instantiate()
		new_quare.position = get_global_mouse_position()
		$/root/Node2D.add_child(new_quare)
		new_quare.name = "Quare"
	if event.is_action_pressed("exagon"):
		if exagons > 1:
			exagons = 1
		if exagons <= 0:
			notifier.notify("No Exagons!")
			return
		
		if not $"../CollisionCheck".is_clear(get_global_mouse_position()):
			$"../CollisionCheck".flash()
			notifier.notify("Too Close!")
			return
		exagons -= 1
		var new_exagon = exagon.instantiate()
		new_exagon.position = get_global_mouse_position()
		$/root/Node2D.add_child(new_exagon)
		new_exagon.name = "Exagon"
		#$Gun.shoot()
		
		
func aquire_quare():
	for child in $"../".get_node("%Ability").get_children():
		if child.value == 100 and not child.animating:
			child.start_countdown(3)
			break
	await get_tree().create_timer(3).timeout
	num_quares -= 1
	$QuareFX.play()
	
func aquire_exagon():
	await get_tree().create_timer(15).timeout
	exagons += 1
	$ExagonFX.play()
