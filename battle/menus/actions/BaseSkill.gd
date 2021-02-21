extends Node
const ELEMENTS = preload('res://imports/Elements.gd'); 
const SKILL_OPTIONS = preload('res://imports/SkillOptions.gd'); 
const SKILL_TYPES = preload('res://imports/SkillTypes.gd'); 

export(String) var _name = ''
export(String) var description = ''
export(SKILL_TYPES.Names) var type
export(int) var cost

export(ELEMENTS.Names, FLAGS) var elements
export(SKILL_OPTIONS.Names, FLAGS) var options

export(String, "enemy", "ally", "self", "random") var initial_target = "enemy"
export var can_target_all = true

var menu 
var user

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = get_parent()

func execute(): #for menu use
	user = menu.overlord.active_character
	menu.overlord.set_active_menu(menu.overlord.get_node('MenuOverlord/TargetMenu'), self)

func use(targets):
	for target in targets:
		print(target)
	end()	

func end():
	user.end_turn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
