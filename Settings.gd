extends Node

var config = ConfigFile.new()

func _ready():
	var has_config = config.load("user://settings.cfg") == OK
	print(has_config)
	$"../Play".disabled = (not has_config) or (has_config and config.get_value("config", "username").unicode_at(0) < 100_000)
	if has_config:
		$Menu/Username.text = config.get_value("config", "username")
		$Menu/Controls.selected = 0 if config.get_value("config", "relative_controls") else 1

func _process(delta):
	check_valid("")

func check_valid(none):
	$Close.disabled = $Menu/Username.text == ""

func save():
	config.set_value("config", "username", $Menu/Username.text)
	config.set_value("config", "relative_controls", $Menu/Controls.selected == 0)
	
	print("Saving!")
	config.save("user://settings.cfg")
