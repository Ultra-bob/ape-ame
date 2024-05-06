extends "res://player.gd"

func _ready():
	update_display()
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")

func _input(event):
	if event.is_action_pressed("jump"):
		global_position = get_global_mouse_position()
	if event.is_action_pressed("quare"):
		if num_quares >= max_quares:
			notifier.notify("All Quares in Use!")
			return
		
		if not $"../CollisionCheck".is_clear(get_global_mouse_position(), 60):
			$"../CollisionCheck".flash()
			notifier.notify("Too Close!")
			return
		num_quares += 1
		var new_quare = quare.instantiate()
		new_quare.position = get_global_mouse_position()
		$/root/Node2D.add_child(new_quare)
		new_quare.name = "Quare"
		update_display()
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
		update_display()
		#$Gun.shoot()
		
		
func aquire_quare():
	await get_tree().create_timer(3).timeout
	num_quares -= 1
	$QuareFX.play()
	update_display()
	
func aquire_exagon():
	await get_tree().create_timer(15).timeout
	exagons += 1
	$ExagonFX.play()
	update_display()

func update_display():
	$"../UI/Quare Count".text = "%d Quares\n" % [(max_quares - num_quares)]

var num_quares = 0
var max_quares = 3
var exagons = 0
