extends TextureProgressBar

var animating = false

signal done_countdown
signal done_countup

func start_countdown(time: float):
	material.set("shader_parameter/strength", 1)
	animating = true
	value = 100
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 0, time)
	await tween.finished
	done_countdown.emit()
	animating = false
	material.set("shader_parameter/strength", 0)
	
func start_countup(time: float):
	material.set("shader_parameter/strength", 1)
	animating = true
	value = 0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 100, time)
	await tween.finished
	done_countup.emit()
	animating = false
	material.set("shader_parameter/strength", 0)
