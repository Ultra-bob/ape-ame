extends "res://player.gd"

var can_jump = true

func _ready():
	speed = 1200
	$"../".get_node("%Ability").add_child(preload("res://portal-ability.tscn").instantiate())
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")

func _input(event):
	if event.is_action_pressed("primary_fire") and can_jump:
		can_jump = false
		$"../".get_node("%Ability/Portal").start_countup(0.5)
		$Sprite.speed_scale = 1
		$Sprite.play("jump")
		await $Sprite.animation_finished
		$"../".get_node("%Ability/Portal").start_countdown(0.5)
		global_position = get_global_mouse_position()
		$Sprite.speed_scale = -1
		$Sprite.play("jump")
		await $Sprite.animation_finished
		$Sprite.play("idle")
		can_jump = true
