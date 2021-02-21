extends "res://battle/menus/actions/BaseSkill.gd" 

export var ranged = false
export(float, 10, 150, 5) var power = 50
export(float, .1, 1.5, .1) var damage_multiplier = 1

func use(targets):
	for target in  targets:
		print(target.character.stats)
		var damage = calc_damage(user, target)
		target.modify_stat('health', -damage)
	.end()

func calc_damage(user, target):
	var total_power = float(power)
	var damage = 0.0
	var strength = float(user.character.stats.strength)
	var defense = float(target.character.stats.defense)
	if type == SKILL_TYPES.Names.physical:
		#if physical, pull in weapon info
		var weapon_power = float(10)
		total_power += weapon_power
	damage = total_power + (strength * 0.25)
	return int(round(damage))
