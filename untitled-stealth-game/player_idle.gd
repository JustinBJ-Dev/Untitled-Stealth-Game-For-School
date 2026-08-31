extends PlayerState

@export var Run_State : PlayerState

func update(delta: float) -> void:
	if player_.dirX != 0 or player_.dirY != 0:
		switch_state.emit(Run_State)
		pass

func physics_update(delta: float) -> void:
	player_.velocity.x = 0
	player_.velocity.y = 0
