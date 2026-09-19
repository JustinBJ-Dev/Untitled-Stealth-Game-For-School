extends StaticBody2D

func _on_hurt_box_took_hit(hit: Attack) -> void:
	queue_free()
