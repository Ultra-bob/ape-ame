extends StaticBody2D

@export var health = 10
var max_health = 10.0

func destroy():
	health -= 1
	
	if health == 1:
		$PowerDownFX.play()
	
	if health <= 0:
		if not is_queued_for_deletion():
			$"..".queue_free()
			$"../../Player".aquire_exagon()
	
	modulate = Color(Color.CYAN, 0.7 - lerp(0.7, 0.1, health / max_health))

