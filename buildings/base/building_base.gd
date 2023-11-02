extends Area

export var building_menu_path : NodePath
onready var building_menu : Node = get_node(building_menu_path)

func _ready():
	pass

func _on_Building_base_body_entered(body):
	if(body.is_in_group("Player")):
		building_menu.show()


func _on_Building_base_body_exited(body):
	if(body.is_in_group("Player")):
		building_menu.hide()
