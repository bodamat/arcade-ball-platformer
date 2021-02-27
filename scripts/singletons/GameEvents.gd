extends Node

signal dead
signal checkpoint

func emit_dead() -> void:
	emit_signal("dead")

func emit_checkpoint(checkpoint_position: Vector3) -> void:
	emit_signal("checkpoint", checkpoint_position)
