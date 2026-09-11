extends EnemyState

@export var Shoot : State

func update(delta: float) -> void:
	if enemy_.is_detecting_player:
		switch_state.emit(Shoot)
	pass
