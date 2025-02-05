extends TextureProgressBar

var animating = false

func start_countdown(time: float):
	material.set("shader_parameter/strength", 1)
	animating = true
	value = 100
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 0, time)
	await tween.finished
	animating = false
	material.set("shader_parameter/strength", 0)
	
func start_countup(time: float):
	material.set("shader_parameter/strength", 1)
	animating = true
	value = 0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", 100, time)
	await tween.finished
	animating = false
	material.set("shader_parameter/strength", 0)
