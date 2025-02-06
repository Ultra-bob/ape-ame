extends CollisionShape2D

func destroy():
	$AnimatedSprite2D.play("die")
