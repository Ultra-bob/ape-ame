extends StaticBody2D

var dying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Turret.target = $"../Player"
	#print($Turret.target)

func destroy():
	if dying:
		return
	dying = true
	var explosion = load("res://explosion.tscn").instantiate()
	$"/root/Node2D".add_child(explosion)
	explosion.global_position = global_position
	await get_tree().create_timer(0.2).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
