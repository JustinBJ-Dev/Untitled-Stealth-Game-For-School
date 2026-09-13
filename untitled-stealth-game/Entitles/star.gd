class_name Star extends Area2D

signal star_collected

func _on_body_entered(body: Node2D) -> void:
	star_collected.emit()
	print(body)
	queue_free()
	pass # Replace with function body.
