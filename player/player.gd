extends KinematicBody
class_name Player

export (NodePath) var joystickPath
onready var joystick : VirtualJoystick = get_node(joystickPath)
export (NodePath) var modelPath
onready var model : Node = get_node(modelPath)
onready var anim : AnimationPlayer = find_node('AnimationPlayer')

export var speed :float = 7
export var gravity := 50

var input_vector := Vector2.ZERO
var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_vector = joystick.get_output()
	
func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = -input_vector.x
	move_direction.z = -input_vector.y
	move_direction = move_direction.normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta

	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)

	if(move_direction.length() > 0):
		#anim.playback_speed = move_direction.length()
		model.look_at(global_transform.origin - move_direction, Vector3.UP)
		anim.play("running-loop")
	else:
		anim.play("idle-loop")
