extends Node2D
var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _init():
	
	if OS.is_debug_build():
		Engine.set_time_scale(0.75)
	
	if config.load("user://settings.cfg") == OK:
		var player = load(config.get_value("gameplay", "class", "res://player-row.tscn")).instantiate()
		player.position = Vector2(1920/2, 1080/2)
		add_child(player)
		
func _ready():
	$Music.volume_db = linear_to_db(config.get_value("config", "music_volume", 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
