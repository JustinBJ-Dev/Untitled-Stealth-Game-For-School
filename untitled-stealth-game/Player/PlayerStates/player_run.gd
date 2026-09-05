extends PlayerState

@export var Idle_State : PlayerState
@export var Dashing : State

@export_category("Properties")
@export var SPEED : int = 300

func update(_delta: float) -> void:
	if player_.dirX == 0 && player_.dirY == 0:
		switch_state.emit(Idle_State)
	
	if Input.is_action_just_pressed("ui_accept"):
		if player_.playerEnergy >= 100:
			switch_state.emit(Dashing)

func physics_update(_delta: float) -> void:
	player_.velocity.x = SPEED * player_.playerInput.x
	player_.velocity.y = SPEED * player_.playerInput.y
