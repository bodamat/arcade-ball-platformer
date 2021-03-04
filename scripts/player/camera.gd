extends Camera

export var look_at_parent := true

var relative_translation: Vector3 = self.translation

func _ready():
	set_as_toplevel(true)
	
	
func _physics_process(_delta):
	var target = get_parent()
	translation = target.translation + relative_translation
	if look_at_parent:
		look_at(target.translation, Vector3.UP)
