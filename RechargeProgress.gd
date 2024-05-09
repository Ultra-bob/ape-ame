extends TextureProgressBar

var animating = false

func start_countdown(time: float):
	animating = true
	value = 100
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 0, time)
	await tween.finished
	animating = false
	
func start_countup(time: float):
	animating = true
	value = 0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 100, time)
	await tween.finished
	animating = false
