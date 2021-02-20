extends Control

var overlord 
var skill
var target_menu_current = 'player'
var menu_item_current = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	overlord = get_parent().get_parent()
	print(overlord.characters)


#called by menu items that are opening the target menu
func init(caller):
	#caller is the skill calling this. Can ge used to reference the skills settings
	skill = caller
	menu_item_set_current()

func menu_item_set_current(_menu_item_current=menu_item_current):
	menu_item_current = _menu_item_current
	menu_item_select()

func menu_item_select(_menu_item_number=menu_item_current):
	reset_selected_targets()
	overlord.characters[target_menu_current][_menu_item_number].toggle_selected(true)	

func _process(_delta):
	if overlord.active_menu == self:
		if target_menu_current != '':
			if Input.is_action_just_pressed("ui_left"):
				target_menu_current = 'enemy'
				menu_item_set_current(0)	
			if Input.is_action_just_pressed("ui_right"):
				target_menu_current = 'player'
				menu_item_set_current(0)	
			if Input.is_action_just_pressed("ui_up"):
				menu_item_current -= 1
				if menu_item_current < 0:
					menu_item_current = overlord.characters[target_menu_current].size() - 1
				menu_item_set_current()	
			if Input.is_action_just_pressed("ui_down"):
				menu_item_current += 1
				if menu_item_current > overlord.characters[target_menu_current].size() - 1:
					menu_item_current = 0
				menu_item_set_current()	
			if Input.is_action_just_pressed("ui_accept"):
				var targets = get_selected_targets()
				skill.use(targets)

func get_selected_targets():
	var targets = []
	for party in overlord.characters:
		var party_characters = overlord.characters[party]
		for i in range(0, party_characters.size()):
			var party_character = party_characters[i]
			if (party_character.selected):
				targets.append(party_character)
	return targets

func reset_selected_targets():
	for party in overlord.characters:
		var party_characters = overlord.characters[party]
		for i in range(0, party_characters.size()):
			var party_character = party_characters[i]
			party_character.toggle_selected(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
