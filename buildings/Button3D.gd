extends StaticBody

export var basePath : NodePath
export(String, FILE, "*.tscn,*.scn") var weaponPath

onready var buildingBase := get_node(basePath)

func _ready():
	pass 

func _on_Button3D_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			$Viewport/Button.emit_signal("pressed")
			$Viewport/Button.set_pressed(true)
		else:
			$Viewport/Button.set_pressed(false)


func _on_Button_pressed():
	buildingBase.spawnWeapon(weaponPath)
