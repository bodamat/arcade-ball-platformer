extends StaticBody




func _on_PlatformTrigger_body_entered(body):
	if(body.get_collision_layer_bit(2)):
		body.set("current_checkpoint", self.translation+Vector3(0,0.6,0))
