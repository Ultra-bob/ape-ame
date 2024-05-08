extends "res://player.gd"

func _ready():
	speed = 1200
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")

func _input(event):
	if event.is_action_pressed("jump"):
		$Sprite.speed_scale = 1
		$Sprite.play("jump")
		await $Sprite.animation_finished
		global_position = get_global_mouse_position()
		$Sprite.speed_scale = -1
		$Sprite.play("jump")
		await $Sprite.animation_finished
		$Sprite.play("idle")
