extends Control

const MAIN_SCENE_PATH = "res://main.tscn"
var tip_level = 1
var config = ConfigFile.new()

func _ready():
	if config.load("user://settings.cfg") == OK:
		if config.get_value("hidden", "tip_level") == null:
			tip_level = 1
			config.set_value("hidden", "tip_level", tip_level)
		else:
			tip_level = config.get_value("hidden", "tip_level")
		
	if randi_range(0, 20) == 5: # small chance to get more and more insane tips as you keep playing
		tip_level += 1
		config.set_value("hidden", "tip_level", tip_level)

func pick(l):
	return l[randi_range(0, len(l)-1)]

func sort_tips():
	var tips = FileAccess.open("res://tips.txt", FileAccess.READ).get_as_text().strip_edges().split("\n")
	var tips_by_level = {1: [], 2: [], 3: []}
	for tip in tips:
		var level = int(tip.split(" | ")[0])
		var text = tip.split(" | ")[1]
		tips_by_level[level].append(text)
	return tips_by_level

func play():
	$"LoadingScreen".show()
	var tip_options = []
	for i in range(1, tip_level+1):
		tip_options += sort_tips()[i]
	
	var tip = pick(tip_options)
	$LoadingScreen/Tip.text = "Tip: %s" % tip
	await get_tree().create_timer(0.2).timeout
	#var game = ResourceLoader.load_threaded_get(MAIN_SCENE_PATH)
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)
