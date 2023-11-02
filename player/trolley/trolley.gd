extends KinematicBody

export var speed : float
export var offset : Vector3
export (NodePath) var targetPath
onready var target : KinematicBody = get_node(targetPath)
onready var agent : NavigationAgent = get_node("NavigationAgent") 

var velocity := Vector3.ZERO
export var gravity := 50

func _ready():
	agent.set_target_location(target.global_transform.origin)

func _physics_process(delta):
	if agent.target_desired_distance < global_transform.origin.distance_to(target.global_transform.origin):
		_update_path()
	
	if agent.is_navigation_finished():
		return
	
	var next_location = agent.get_next_location()
	var direction = global_transform.origin.direction_to(next_location)
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 4.0
	
	velocity += steering
	velocity.y -= gravity * delta
	
	velocity = move_and_slide(velocity)
	
	if next_location.x != transform.origin.x and next_location.z != transform.origin.z:
		turn(next_location)
	
func _update_path():
	var transformOfTarget = target.get('model').global_transform
	var location = transformOfTarget.origin - (-transformOfTarget.basis.z * offset.z)
	agent.set_target_location(location)

func turn(location):
	var global_pos = transform.origin
	var rotation_speed = 0.1
	var wtransform = transform.looking_at(Vector3(location.x,global_pos.y,location.z),Vector3(0,1,0))
	var wrotation = Quat(transform.basis).slerp(Quat(wtransform.basis), rotation_speed)

	transform = Transform(Basis(wrotation), transform.origin)
