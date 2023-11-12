extends Area

export var building_menu_path : NodePath
onready var building_menu : Node = get_node(building_menu_path)

var weaponNode : Node

func _ready():
	pass

func _on_Building_base_body_entered(body):
	if(body.is_in_group("Player") && !weaponNode):
		building_menu.set_process(true)
		building_menu.show()


func _on_Building_base_body_exited(body):
	if(body.is_in_group("Player")):
		building_menu.hide()
		building_menu.set_process(false)

func spawnWeapon(path):
	var scene = load(path)
	var weapon = scene.instance()
	add_child(weapon)
	weaponNode = weapon
	building_menu.hide()
	building_menu.set_process(false)
