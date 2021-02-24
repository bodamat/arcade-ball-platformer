extends CollisionShape

export var material: Material setget set_material, get_material


func set_material(value):
	$MeshInstance.mesh.surface_set_material(0,value)
func get_material():
	return $MeshInstance.mesh.surface_get_material(0)

