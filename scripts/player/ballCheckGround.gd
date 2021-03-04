extends RayCast


func _ready():
	set_as_toplevel(true)
	
	
func _physics_process(_delta):
	translation = get_parent().translation
