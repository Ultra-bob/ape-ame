extends Control

const MAIN_SCENE_PATH = "res://main.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Layout/Play.disabled = true
	ResourceLoader.load_threaded_request(MAIN_SCENE_PATH)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var progress = ResourceLoader.load_threaded_get_status(MAIN_SCENE_PATH)
	if progress == ResourceLoader.THREAD_LOAD_LOADED:
		$Layout/Play.disabled = false
		$Layout/Play.text = "Play"

func play():
	var game = ResourceLoader.load_threaded_get(MAIN_SCENE_PATH)
	get_tree().change_scene_to_packed(game)
