extends Path

export var speed := 5
export var loop := false
export var auto_play := false

onready var path_follow = $PathFollow
var direction := 1
var follow_player: Node

func _ready():
	path_follow.loop = loop
	set_process(auto_play)

func _process(delta):
	var last_translation = translation
	path_follow.offset += speed * direction * delta
	
	
	if path_follow.unit_offset == 1 or path_follow.unit_offset == 0:
		direction *= -1;
	
#	if follow_player:
#		follow_player.translation += (translation - last_translation)


func _on_PlatformTrigger_body_entered(body):
	if body.get_collision_layer_bit(2):
		follow_player = body


func _on_PlatformTrigger_body_exited(body):
	if body.get_collision_layer_bit(2):
		follow_player = null
