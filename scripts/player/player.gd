extends RigidBody

export var speed := 7000.0
export var jump_power := 4000.0

onready var sphere_mesh := $CollisionShape/MeshInstance.mesh as SphereMesh

var current_checkpoint := Vector3(0,1,0)

func _ready():
	GameEvents.connect("checkpoint", self, "set_current_checkpoint")
	GameEvents.connect("dead", self, "dead")

func _physics_process(delta):
	if translation.y<-5:
		GameEvents.emit_dead()
	else:
		var direction = get_move_direciton()
		apply_central_impulse(direction*speed*delta + Vector3(0,get_jump()*jump_power,0))

func set_current_checkpoint(checkpoint_position: Vector3):
	current_checkpoint = checkpoint_position + Vector3.UP * (sphere_mesh.radius + 0.1)

func is_on_floor()->bool:
	return $RayCast.is_colliding()

func get_jump()->int:
	return int(Input.is_action_just_pressed("jump"))*int(is_on_floor())

func get_move_direciton()->Vector3:
	var direction = Vector3(
		Input.get_action_strength("move_forward")-Input.get_action_strength("move_backwards"),
		0,
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	)
	direction = direction.normalized()
	if not is_on_floor():
		direction/=2
	return direction

func respawn():
	mode = MODE_STATIC
	translation = current_checkpoint
	mode = MODE_RIGID

func dead():
	respawn()
