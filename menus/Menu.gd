extends Control
export(Array, String) var menu_item_names
export(NodePath) var base_menu_item_action_preload setget set_base_menu_item_action

var active = false
var menu_items = []
var menu_item_current = 0
var base_menu_item_action = null

var overlord 
var key_master

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	overlord = get_parent().get_parent() #got to be a better way...
	key_master = overlord.get_node("KeyMaster")
	for i in range(0, menu_item_names.size()):
		var menu_item_name = menu_item_names[i]
		var menu_item = inst_menu_item(menu_item_name, 0, i * 10)
		menu_items.append(menu_item)
	init(null)

func init(_caller):
	menu_item_current = 0
	menu_items[0].toggle_selected(true)

func set_base_menu_item_action(value):
	base_menu_item_action = value

func menu_item_set_current(_menu_item_current=menu_item_current):
	menu_item_current = _menu_item_current
	menu_item_select()

func menu_item_select(_menu_item_number=menu_item_current):
	for i in range(0, menu_items.size()):
		var menu_item = menu_items[i]
		menu_item.toggle_selected(false)
	menu_items[_menu_item_number].toggle_selected(true)	

func inst_menu_item(text, x, y):
	var item_scene = load("res://menus/MenuItem.tscn")
	var item_instance = item_scene.instance()
	item_instance.rect_position.x = x
	item_instance.rect_position.y = y
	add_child(item_instance)
	var label = item_instance.get_node('Label')
	label.text = str(text)
	return item_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if overlord.active_menu == self:
		if key_master.key_pressed("ui_up"):
			menu_item_current -= 1
			if menu_item_current < 0:
				menu_item_current = menu_items.size() - 1
			menu_item_set_current()	
		if key_master.key_pressed("ui_down"):
			menu_item_current += 1
			if menu_item_current > menu_items.size() - 1:
				menu_item_current = 0
			menu_item_set_current()	
		if key_master.key_pressed("ui_accept"):
			var menu_item_action = get_node('MenuItem' + menu_item_names[menu_item_current])
			if menu_item_action != null:
				menu_item_action.execute()
			elif base_menu_item_action != null:
				base_menu_item_action.execute()
			else:
				print("INVALID ACTION")

func _on_KeyMaster_signal_ui_key(key_name):
	pass
