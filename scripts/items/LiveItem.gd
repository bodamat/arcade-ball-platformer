extends Area

func _on_LiveItem_body_entered(body):
	if body.get_collision_layer_bit(2):
		GameEvents.emit_add_live()
		queue_free()
