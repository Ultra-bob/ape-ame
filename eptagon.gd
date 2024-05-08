extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Turret.target = $"../Player"
	#print($Turret.target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
