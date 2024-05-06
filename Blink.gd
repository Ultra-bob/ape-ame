extends "res://LockedRotation.gd"

@export var off_color = Color.TRANSPARENT
	
func blink():
	while true:
		self_modulate = off_color
		await $Timer.timeout
		self_modulate = Color.WHITE
		await $Timer.timeout
