extends Area2D
var character_name
var character_stats
var character_stats_current
var character_party = ''
var current_turn_tick = 0
var turn_tick_max = 100
var selected = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(_name, _path, _party):
	character_name = _name
	var character = load("res://battle/characters/" + _path + ".gd").new();
	character_stats = str2var(var2str(character.stats))
	character_stats_current = str2var(var2str(character.stats))
	character_party = _party
	
func turn_tick():
	var speed = character_stats['speed']
	var rand = rand_range(0, speed) * .25
	var tick_rate = speed + rand #modify this later to include all the factors
	current_turn_tick += tick_rate
	if current_turn_tick > turn_tick_max:
		current_turn_tick -= turn_tick_max
		return true
	return false

func toggle_selected(_selected=!selected):
	selected = _selected 
	if selected:
		$Selector.show()
	else:
		$Selector.hide()

func modify_stat(stat, value):
	character_stats_current[stat] += value
	if (character_stats_current[stat]) < 0:
		character_stats_current[stat] = 0
	print(character_stats_current)
	if stat == 'health':
		print(character_stats[stat])
		print(character_stats_current[stat])
		var perc = float(character_stats_current[stat]) / float(character_stats[stat]) * 100
		print(perc)
		$HealthBar.set_value(perc)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
