extends RigidBody

export var speed := 100.0

func get_move_direciton()->Vector3:
	var direction = Vector3(
		Input.get_action_strength("move_forward")-Input.get_action_strength("move_backwards"),
		0,
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	)
	
	if direction.x!=0 and direction.z!=0:
		direction/=2
	return direction



func _physics_process(delta):
	var direction = get_move_direciton()
	apply_central_impulse(direction*speed*delta)
