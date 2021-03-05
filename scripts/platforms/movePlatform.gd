extends Path

export var speed := 2
export var loop := false
export var auto_play := false

onready var path_follow = $PathFollow
onready var platform = $PathFollow/KinematicBody
var direction := 1

func _ready():
	path_follow.loop = loop
	set_process(auto_play)

func _process(delta):
	path_follow.offset += speed * direction * delta
	
	if path_follow.unit_offset == 1 or path_follow.unit_offset == 0:
		direction *= -1;


func _on_PlatformTrigger_body_entered(body: Spatial):
	pass
#	if body.get_parent() == platform:
#		return
#
#	var ball_trans = body.get_global_transform()
#	body.get_parent().remove_child(body)
#	$PathFollow/KinematicBody.add_child(body)
#	body.set_global_transform(ball_trans)
