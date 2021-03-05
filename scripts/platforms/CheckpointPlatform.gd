extends StaticBody

export var check_material: Material = preload("res://materials/platforms/check_checkpoint.tres")
export var check_material_cylinder: Material = preload("res://materials/platforms/check_checkpoint_cylinder.tres")

onready var platform_mesh = $PlatformModel/MeshInstance
onready var cylinder = $Cylinder

enum STATE { UNCHECK = 0, CHECK = 1 }

func _ready():
	GameEvents.connect("checkpoint", self, "on_checkpoint")

func on_checkpoint(_position: Vector3):
	change_material(STATE.UNCHECK)

func change_material(state: int):
	platform_mesh.material_override = check_material if state == STATE.CHECK else null
	cylinder.material_override = check_material_cylinder if state == STATE.CHECK else null

func _on_PlatformTrigger_body_entered(body):
	if(body.get_collision_layer_bit(2)):
		GameEvents.emit_checkpoint(self.get_global_transform().origin)
		change_material(STATE.CHECK)
