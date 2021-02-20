extends Control
export var selected = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggle_selected(_selected=!selected):
	selected = _selected 
	if selected:
		$Selector.show()
	else:
		$Selector.hide()
