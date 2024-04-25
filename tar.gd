extends Node2D

func phase():
	$Sprite.play("spawn")
	$"Riangle Zone".spawn()
	await get_tree().create_timer(1).timeout
	$Sprite.play("idle")
	$"Riangle Zone".eject()
