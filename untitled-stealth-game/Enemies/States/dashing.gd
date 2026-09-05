extends EnemyState

var direction : Vector2

@export var wait_time : float = 1
@export var dashing_speed : int = 500 

var dashingTimer : Timer

@export_category("States")
@export var Idle : State

func enter_state() -> void:
	enemy_.set_collision_mask_value(1, false)
	
	dashingTimer = Timer.new()
	dashingTimer.set_wait_time(wait_time)
	add_child(dashingTimer)
	dashingTimer.timeout.connect(timeout)
	dashingTimer.start()
	
	enemy_.navigating = false
	direction = enemy_.global_position.direction_to(enemy_.target.global_position)
	enemy_.SPEED = dashing_speed
	
	pass

func physics_update(delta: float) -> void:
	enemy_.velocity = direction * dashing_speed
	
	if enemy_.is_on_wall():
		
		switch_state.emit(Idle)

func timeout() -> void:
	if enemy_.global_position.distance_to(enemy_.target.global_position) > 64:
		switch_state.emit(Idle)

func exit_state() -> void:
	enemy_.navigating = true
	dashingTimer.queue_free()
	enemy_.set_collision_mask_value(1, true)
