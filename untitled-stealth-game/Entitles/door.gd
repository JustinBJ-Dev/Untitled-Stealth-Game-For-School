class_name Door extends Area2D

func open() -> void:
	self.modulate = Color("7f7f7fff")
	self.set_collision_mask_value(1, true)
	pass



func _on_body_entered(body: Node2D) -> void:
	print("Finished")
	pass # Replace with function body.
