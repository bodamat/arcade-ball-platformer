extends RigidBody
class_name Player

onready var sphere_mesh := $CollisionShape/MeshInstance.mesh as SphereMesh

export var speed := 7000.0
export var jump_power := 4000.0

export var max_lives_count := 5
export var start_lives_count := 3
var lives : int

var current_checkpoint := Vector3(0,1,0)
var spawn_up_offset := 0.1

func _ready():
	lives = start_lives_count
	GameEvents.connect("checkpoint", self, "set_current_checkpoint")
	GameEvents.connect("dead", self, "dead")
	GameEvents.connect("game_over", self, "game_over")
	GameEvents.connect("respawn", self, "respawn")
	GameEvents.connect("add_live", self, "add_live")
	current_checkpoint = translation + Vector3.UP * spawn_up_offset

func _physics_process(delta):
	if translation.y<-5:
		GameEvents.emit_dead()
	else:
		var direction = get_move_direciton()
		apply_central_impulse(direction*speed*delta + Vector3(0,get_jump()*jump_power,0))

func set_current_checkpoint(checkpoint_position: Vector3):
	current_checkpoint = checkpoint_position + Vector3.UP * (sphere_mesh.radius + spawn_up_offset)

func is_on_floor()->bool:
	return $RayCast.is_colliding()

func get_jump()->int:
	return int(Input.is_action_just_pressed("jump"))*int(is_on_floor())

func get_move_direciton()->Vector3:
	var direction = Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0,
		Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forward")
	)
	direction = direction.normalized()
	if not is_on_floor():
		direction/=2
	return direction

func add_live():
	if lives<max_lives_count:
		lives+=1
	print("lives: ",lives)

func respawn():
	mode = MODE_STATIC
	translation = current_checkpoint
	mode = MODE_RIGID
	print("lives: ",lives)
	
func game_over():
	print("Game over!")
	queue_free()
	
func dead():
	lives-=1
	if lives<=0:
		GameEvents.emit_game_over()
	else:
		GameEvents.emit_respawn()
