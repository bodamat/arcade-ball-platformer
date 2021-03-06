extends Node

signal dead
signal game_over
signal respawn
signal checkpoint

signal add_live

func emit_add_live() -> void:
	emit_signal("add_live")

func emit_dead() -> void:
	emit_signal("dead")
	
func emit_game_over() -> void:
	emit_signal("game_over")
	
func emit_respawn() -> void:
	emit_signal("respawn")

func emit_checkpoint(checkpoint_position: Vector3) -> void:
	emit_signal("checkpoint", checkpoint_position)
