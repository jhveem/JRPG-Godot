extends Area2D
var character = {
	'name': '',
	'stats_base': {},
	'stats': {},
	'party': ''
}  
var start_x = 0
var start_y = 0
var current_turn_tick = 0
var turn_tick_max = 100
var selected = false
var battle_overlord

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(_name, _path, _party, _x, _y):
	character.name = _name
	var character_info = load("res://battle/characters/" + _path + ".gd").new();
	character_info._init()
	character.stats_base = str2var(var2str(character_info.stats))
	character.stats = str2var(var2str(character_info.stats))
	character.party = _party
	start_x = _x
	start_y = _y
	position.x = _x
	position.y = _y
	
func turn_tick():
	var speed = character.stats['speed']
	var rand = rand_range(0, speed) * .25
	var tick_rate = speed + rand #modify this later to include all the factors
	current_turn_tick += tick_rate
	if current_turn_tick > turn_tick_max:
		current_turn_tick -= turn_tick_max
		return true
	return false

func toggle_active():
	if battle_overlord.active_character == self:
		var w = (ProjectSettings.get_setting("display/window/size/width"))
		if start_x > w / 2:
			position.x = start_x - 8
		else:
			position.x = start_x + 8
	else:
		position.x = start_x


func toggle_selected(_selected=!selected):
	selected = _selected 
	if selected:
		$Selector.show()
	else:
		$Selector.hide()

func modify_stat(stat, value):
	character.stats[stat] += value
	if (character.stats[stat]) < 0:
		character.stats[stat] = 0
	if stat == 'health':
		var perc = float(character.stats[stat]) / float(character.stats_base[stat]) * 100
		$HealthBar.set_value(perc)

func end_turn():
	battle_overlord.turn_tick()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
