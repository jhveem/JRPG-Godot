extends Node

var active_menu

var characters = {
	'player': [],
	'enemy': []
} 
var ready_characters = []
var active_character

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	load_character('knight', 'players/Knight', 68, 48, 'enemy')
	load_character('knight', 'players/Knight', 252, 48, 'player')
	load_character('wizard 1', 'players/Wizard', 252, 80, 'player')
	load_character('wizard 2', 'players/Wizard', 252, 112, 'player')

	active_menu = $MenuOverlord/ActionMenu
	print(active_menu)
	
	turn_tick()
	
func set_active_menu(menu, caller = null):
	active_menu = menu
	menu.init(caller)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# if Input.is_action_just_pressed("ui_accept"):
	if false:
		ready_characters.pop_front()
		turn_tick()
		
func turn_tick():
	while ready_characters.size() == 0:
		for party in characters:
			var party_characters = characters[party]
			for character in party_characters:
				if character.turn_tick():
					ready_characters.append(character)
	
	active_character = ready_characters[0]
	print(active_character.character_name)

func load_character(name, path, x, y, party):
	var character_scene = load("res://battle/BattleCharacter.tscn")
	var character_inst = character_scene.instance()
	characters[party].append(character_inst)
	character_inst.position.x = x
	character_inst.position.y = y
	character_inst.init(name, path, party)
	add_child(character_inst)
