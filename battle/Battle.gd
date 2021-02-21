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
	load_character('knight', 'Tophat', 'players/Knight', 68, 48, 'enemy')
	load_character('knight 2', 'Knight', 'players/Knight', 252, 48, 'player')
	load_character('wizard 1', 'Wizard', 'players/Wizard', 252, 80, 'player')
	load_character('wizard 2', 'Wizard', 'players/Wizard', 252, 112, 'player')

	active_menu = $MenuOverlord/ActionMenu
	
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

func end_turn():
	pass
		
func turn_tick():
	#check for victory / loss

	for i in range(0, len(ready_characters)):
		var _i = len(ready_characters) - (i + 1)
		var character = ready_characters[_i]
		if character.character.stats.health <= 0:
			ready_characters.remove(_i)

	while ready_characters.size() == 0:
		for party in characters:
			var party_characters = characters[party]
			for character in party_characters:
				if character.character.stats.health > 0:
					if character.turn_tick():
						ready_characters.append(character)

	active_character = ready_characters[0]
	ready_characters.pop_front()

	active_character.battle_overlord = self
	for type in characters:
		for character in characters[type]:
			character.toggle_active()

	active_menu = $MenuOverlord/ActionMenu
	print(active_character.character.name)

func load_character(name, character_name, path, x, y, party):
	var character_scene = load("res://battle/BattleCharacter.tscn")
	var character_inst = character_scene.instance()
	characters[party].append(character_inst)
	character_inst.battle_overlord = self
	character_inst.init(name, character_name, path, party, x, y)
	add_child(character_inst)
