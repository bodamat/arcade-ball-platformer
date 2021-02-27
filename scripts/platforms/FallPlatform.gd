extends RigidBody

export var fall_distance := 20.0
export var fall_wait_time := 0.5

var start_pos := Vector3(0, 0, 0)
var falling := false

func _ready():
	start_pos = transform.origin

func _process(_delta):
	if abs(transform.origin.y - start_pos.y) > fall_distance and falling:
		stop_fall()

func begin_fall() -> void:
	mode = RigidBody.MODE_RIGID
	falling = true

func stop_fall() -> void:
	mode = RigidBody.MODE_STATIC
	transform.origin = start_pos
	falling = false

func _on_Timer_timeout():
	begin_fall()

func _on_PlatformTrigger_body_entered(body):
	if body.get_collision_layer_bit(2) and not falling:
		$Timer.start(fall_wait_time)
