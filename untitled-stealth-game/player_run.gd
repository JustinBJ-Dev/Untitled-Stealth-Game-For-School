extends PlayerState

@export var Idle_State : PlayerState

@export_category("Properties")
@export var SPEED : int = 300

func update(delta: float) -> void:
	if player_.dirX == 0 && player_.dirY == 0:
		switch_state.emit(Idle_State)

func physics_update(delta: float) -> void:
	player_.velocity.x = SPEED * player_.dirX
	player_.velocity.y = SPEED * player_.dirY
