extends PlayerState

@export var wait_time : float = 1
@export var dashing_speed : int = 750 

var dashingTimer : Timer

@export_category("States")
@export var Idle : State


func enter_state() -> void:
	dashingTimer = Timer.new()
	dashingTimer.set_wait_time(wait_time)
	add_child(dashingTimer)
	dashingTimer.timeout.connect(timeout)
	dashingTimer.start()
	
	player_.playerEnergy = 0
	pass

func physics_update(delta: float) -> void:
	player_.velocity = player_.playerDirection * dashing_speed

func timeout() -> void:
	switch_state.emit(Idle)
	pass

func exit_state() -> void:
	dashingTimer.queue_free()
