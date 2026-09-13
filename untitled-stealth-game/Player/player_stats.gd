extends Node

@export var player : player

func _on_hurt_box_took_hit(hit: Attack) -> void:
	player._take_damage(hit.attack_damage)
	if player.playerHealth <= 0:
		player.die()
	pass # Replace with function body.
