extends Node

var config = ConfigFile.new()

const CHARACTERS = ["res://player-row.tscn", "res://player-apezoid.tscn"]

func _ready():
	var has_config = config.load("user://settings.cfg") == OK
	print(has_config)
	$"../Layout/Play".disabled = not has_config
	if has_config:
		$Menu/Username.text = config.get_value("config", "username")
		$Menu/Controls.selected = 0 if config.get_value("config", "relative_controls") else 1
		$Menu/Character.selected = CHARACTERS.find(config.get_value("gameplay", "class"))

func _process(delta):
	check_valid("")

func check_valid(none):
	$Close.disabled = len($Menu/Username.text) != 3

func save():
	config.set_value("config", "username", $Menu/Username.text)
	config.set_value("config", "relative_controls", $Menu/Controls.selected == 0)
	
	config.set_value("gameplay", "class", CHARACTERS[$Menu/Character.selected])
	
	print("Saving!")
	config.save("user://settings.cfg")
	$"../Layout/Play".disabled = false
