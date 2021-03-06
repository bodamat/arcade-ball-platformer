extends Node

signal dead
signal lost
signal respawn
signal checkpoint

signal add_live

func emit_add_live() -> void:
	emit_signal("add_live")

func emit_dead() -> void:
	emit_signal("dead")
	
func emit_lost() -> void:
	emit_signal("lost")
	
func emit_respawn() -> void:
	emit_signal("respawn")

func emit_checkpoint(checkpoint_position: Vector3) -> void:
	emit_signal("checkpoint", checkpoint_position)
