extends StaticBody2D

func shoot():
	
	$Turret.target = find_target()
	
	if not $Turret.target:
		return
	
	$Turret/AnimatedSprite2D.play("shoot")
	
	await $Turret/AnimatedSprite2D.animation_finished
	$Turret/Gun.shoot()
	
	$Turret/AnimatedSprite2D.play("default")
	
	$Turret.target = find_target()
	
	$ShootTimer.start(1)
	

func find_target():
	
	if len(get_tree().get_nodes_in_group("enemy")) <= 0:
		print("Error! nothing to heal")
		return null
	
	var enemies = get_tree().get_nodes_in_group("enemy")
			
	return enemies[randi_range(0, len(enemies)-1)]
