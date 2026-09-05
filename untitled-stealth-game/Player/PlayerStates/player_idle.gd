extends PlayerState

@export var Run_State : PlayerState
@export var Dashing : State


func update(_delta: float) -> void:
	if player_.dirX != 0 or player_.dirY != 0:
		switch_state.emit(Run_State)
	
	if Input.is_action_just_pressed("ui_accept"):
		if player_.playerEnergy >= 100:
			switch_state.emit(Dashing)

func physics_update(_delta: float) -> void:
	player_.velocity.x = 0
	player_.velocity.y = 0
