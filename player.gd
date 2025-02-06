extends RigidBody2D

var speed = 1000  # move speed in pixels/sec
var rotation_speed = 3  # turning speed in radians/sec
var quare = preload("res://quare.tscn")
var exagon = preload("res://exagon.tscn")
@onready var notifier = $"../Notification"
var absolute_movement = false
var config = ConfigFile.new()

var moving = false
var frozen = false

func update_animation():
	pass

func _ready():
	update_animation()
	if config.load("user://settings.cfg") == OK:
		absolute_movement = not config.get_value("config", "relative_controls")

func _integrate_forces(state):
	look_at(get_global_mouse_position())

func _physics_process(delta):
	if frozen:
		return
	var move_input = Input.get_axis("down", "up")
	var side_input = Input.get_axis("right", "left")
	if move_input != 0 or side_input != 0:
		moving = true
		update_animation()
	else:
		moving = false
		update_animation()
	
	if absolute_movement:
		apply_central_force(Vector2(side_input, move_input).normalized() * -speed * linear_damp) 
	else:
		apply_central_force(transform.y * side_input * speed / -2 + transform.x * move_input * speed * linear_damp)

func destroy():
	if has_node("Shield"):
		$Shield.destroy()
		return
	$DeathFX.play()
	get_tree().paused = true
	$"../GameOver".visible = true
