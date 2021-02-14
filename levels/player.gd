extends RigidBody

export var SPEED := 10.0
export(NodePath) onready var camera = get_node(camera) as Camera

func _physics_process(delta):
	var torque := Vector3(0, 0, 0)
	
	if Input.is_action_pressed("move_forward"):
		torque.z = -1
	elif Input.is_action_pressed("move_backwards"):
		torque.z = 1
	
	if Input.is_action_pressed("move_right"):
		torque.x = -1
	elif Input.is_action_pressed("move_left"):
		torque.x = 1
	
	torque *= SPEED
	
	torque.z *= camera.get_global_transform().basis.z
	torque.x *= camera.get_global_transform().basis.x
	
	add_torque(torque)
