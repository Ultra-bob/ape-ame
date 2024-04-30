extends StaticBody2D

@onready var player = $"../Player"
var idle_texture = preload("res://dotted line.png")
var aiming_texture = preload("res://laser_idle.png")
var active_texture = preload("res://ircle_laser.gif")
var aiming = true
var can_damage = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if aiming:
		look_at(player.global_position)
	if can_damage:
		var body = $Line2D/RayCast2D.get_collider()
		if body != null and body.is_in_group("destructible"):
			if body.has_method("destroy"):
				body.destroy()
			else:
				body.queue_free()
			can_damage = false

func fire_laser():
	var tween = get_tree().create_tween()
	$Sprite2D.play("gif")
	aiming = false
	tween.set_parallel(true)
	tween.tween_callback(set_laser_texture.bind(aiming_texture))
	tween.tween_property($Line2D, "modulate", Color.WHITE, 1).set_ease(Tween.EASE_IN)
	tween.tween_callback(play_with_delay)
	tween.set_parallel(false)
	tween.tween_callback(can_shoot.bind(true))
	tween.tween_callback(set_laser_texture.bind(active_texture))
	tween.tween_callback($Sprite2D.pause)
	tween.tween_callback($Line2D.fire)
	tween.tween_interval(0.2)
	tween.tween_callback(can_shoot.bind(false))
	tween.tween_callback(set_laser_texture.bind(aiming_texture))
	tween.set_parallel(true)
	tween.tween_property($Line2D, "modulate", Color(Color.WHITE, 0.2), 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_callback($Sprite2D.stop)
	tween.set_parallel(false)
	tween.tween_callback(start_aim)
	tween.tween_callback(set_laser_texture.bind(idle_texture))
	
func play_with_delay():
	await get_tree().create_timer(0.9).timeout
	$LaserFX.play()
	
func set_laser_texture(texture):
	$Line2D.texture = texture

func start_aim():
	aiming = true
	
func can_shoot(yn):
	can_damage = yn

var dying = false

func destroy():
	if dying:
		return
	dying = true
	var explosion = load("res://explosion.tscn").instantiate()
	$"/root/Node2D".add_child(explosion)
	explosion.global_position = global_position
	await get_tree().create_timer(0.2).timeout
	queue_free()
