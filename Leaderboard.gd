extends Label

@export var stopwatch: Stopwatch
var config = ConfigFile.new()

var API_BASE = "https://flask-hello-world-nine-psi.vercel.app" if not OS.is_debug_build() else "http://192.168.2.120:5001"

func make_urlsafe(data: String):
	return data.replace("+", "-").replace("/", "_")

func get_scores():
	$HTTPRequest.request(API_BASE + "/leaderboard")
	
func submit_score():
	var err = config.load("user://settings.cfg")
	if not (err == OK and config.has_section_key("config", "username")):
		text = "Error: No Username!\nSet a username in settings to submit scores"
	var encrypted_score = "EGH" + make_urlsafe(Marshalls.utf8_to_base64(str(stopwatch.time_elapsed))) + "eHa" + make_urlsafe(Marshalls.utf8_to_base64(config.get_value("config", "username")))
	print(encrypted_score)
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request(API_BASE + "/leaderboard?score=%s" % encrypted_score, [], HTTPClient.METHOD_POST)

func _on_request_completed(result, response_code, headers, body):
	if body.get_string_from_utf8() == "OK":
		get_scores()
		return true
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json)
	if json and "scores" in json:
		var scoredata = json["scores"]
		var scores = []
		for score in scoredata:
			scores.append(float(score[1]))
		print(scores)
		var score = stopwatch.time_elapsed
		print(score)
		var placement = closest(score, scores)
		print(placement)
		
		if placement < 50:
			text = "You placed #%d\n" % [placement]
		else:
			text = "You placed top %d%%\n" % [(float(placement) / len(scores)) * 100]
		var n = 1
		while n <= 5 and n <= len(scores):
			text += "%d. %s: %s\n" % [ n, scoredata[n-1][0], seconds2mmss(scores[n-1]) ]
			n += 1

func closest(my_number:int, my_array:Array)->int:
	# Initialize
	var closest_num:int
	var closest_delta:int = 0
	var closest_idx = -1
	var temp_delta:int = 0
	# Loop through entire array
	for i in range(my_array.size()):
		if my_array[i] == my_number:
			print("Exact Match!")
			return my_array[i] # exact match found!
		temp_delta = int(abs(my_array[i]-my_number))
		if closest_delta == 0 or temp_delta < closest_delta:
			closest_num = my_array[i]
			closest_idx = i
			closest_delta = temp_delta
	# Return closest number found
	return closest_idx

func seconds2mmss(total_seconds: float) -> String:
	var seconds: float = fmod(total_seconds , 60.0)
	var minutes: int   =  int(total_seconds / 60.0) % 60
	var hhmmss_string: String = "%02d:%05.2f" % [minutes, seconds]
	return hhmmss_string
