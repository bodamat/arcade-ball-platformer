extends Path

export var speed := 2
export var loop := false
export var auto_play := false

onready var path_follow = $PathFollow
var direction := 1

func _ready():
	path_follow.loop = loop
	set_process(auto_play)

func _process(delta):
	path_follow.offset += speed * direction * delta
	
	if path_follow.unit_offset == 1 or path_follow.unit_offset == 0:
		direction *= -1;
