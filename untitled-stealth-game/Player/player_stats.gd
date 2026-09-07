extends Node

@export var player : player

var playerHealth : float = 3.0


func _on_hurt_box_took_hit(hit: Attack) -> void:
	player._take_damage(hit.attack_damage)
	pass # Replace with function body.
