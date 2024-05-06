extends Node2D
var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.load("user://settings.cfg") == OK:
		var player = load(config.get_value("gameplay", "class", "res://player-row.tscn")).instantiate()
		player.position = Vector2(1920/2, 1080/2)
		add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
