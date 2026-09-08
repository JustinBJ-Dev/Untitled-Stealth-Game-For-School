extends PlayerState

@export var Idle_State : PlayerState
@export var Dashing : State

@export_category("Properties")
@export var SPEED : int = 300
@export var ACCEL : float = 0.75

func update(_delta: float) -> void:
	if player_.dirX == 0 && player_.dirY == 0:
		switch_state.emit(Idle_State)
	
	if Input.is_action_just_pressed("input_dash"):
		if player_.playerEnergy >= 100:
			switch_state.emit(Dashing)

func physics_update(_delta: float) -> void:
	player_.velocity.x = lerp(player_.velocity.x, SPEED * player_.playerInput.x, ACCEL)
	player_.velocity.y = lerp(player_.velocity.y, SPEED * player_.playerInput.y, ACCEL)
