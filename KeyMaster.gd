extends Node
var keys = {}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_key(key_name):
	keys[key_name] = {
		'pressed': false,
		'released': true,
		'steps_pressed': 0
	}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_key(key_name):
	if !(key_name in keys):
		add_key(key_name)

	if Input.is_action_pressed(key_name) && keys[key_name].released:
		keys[key_name].pressed = true
		keys[key_name].released = false 
	if Input.is_action_just_released(key_name):
		keys[key_name].pressed = false
		keys[key_name].released = true

func key_pressed(key_name):
	if key_name in keys:
		if keys[key_name].pressed:
			keys[key_name].pressed = false
			return true
	return false

func _process(delta):
	process_key("ui_accept")
	process_key("ui_cancel")
	process_key("ui_up")
	process_key("ui_down")
	process_key("ui_left")
	process_key("ui_right")

