extends "res://player.gd"

var can_damage = false
var shooting = false

var idle_texture = preload("res://dotted line.png")
var aiming_texture = preload("res://laser_idle.png")
var active_texture = preload("res://laser_idle.png")

func _ready():
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")
	speed = 750

func update_animation():
	if moving:
		$Engine.play("active")
	else:
		$Engine.play("idle")

func _input(event):
	if event.is_action_pressed("shoot") and speed != 0:
		$Laser.fire()
		fire_laser()

func _process(delta):

	if can_damage:
		var body = $Laser/RayCast2D.get_collider()
		if body != null and (body.is_in_group("destructible") or body.name == "Entagon"):
			if body.has_method("destroy"):
				body.destroy()
			else:
				body.queue_free()

func fire_laser():
	var tween = get_tree().create_tween()
	speed = 0
	$Body.play("shoot")
	tween.set_parallel(true)
	tween.tween_callback(set_laser_texture.bind(aiming_texture))
	tween.tween_property($Laser, "modulate", Color.WHITE, 1).set_ease(Tween.EASE_IN)
	tween.tween_callback(play_with_delay)
	tween.set_parallel(false)
	tween.tween_callback(set_laser_texture.bind(active_texture))
	tween.tween_callback($Laser.fire)
	tween.tween_property(self, "can_damage", true, 0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "can_damage", false, 0)
	tween.tween_callback(set_laser_texture.bind(aiming_texture))
	tween.set_parallel(true)
	tween.tween_property($Laser, "modulate", Color(Color.WHITE, 0.2), 0.2).set_ease(Tween.EASE_OUT)
	tween.set_parallel(false)
	tween.tween_callback(set_laser_texture.bind(idle_texture))
	tween.tween_callback($Body.play.bind("idle"))
	tween.tween_property(self, "speed", 750, 0)
	

	
func play_with_delay():
	await get_tree().create_timer(0.9).timeout
	$LaserFX.play()
	
func set_laser_texture(texture):
	$Laser.texture = texture
