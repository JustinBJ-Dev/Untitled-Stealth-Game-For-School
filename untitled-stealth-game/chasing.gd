extends EnemyState

@export_category("Properties")
@export var enemy_speed : int = 100
@export var naviagation_timer_wait_time : float = 0.1

@export_category("States")
@export var Idle : State
@export var detectionCast : RayCast2D

var navTimer : Timer

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)

func enter_state() -> void:
	enemy_.SPEED = enemy_speed
	navTimer.start()
	
	enemy_.target = enemy_.player_node
	pass

func physics_update(_delta: float) -> void:
	is_detecting_player()

func is_detecting_player() -> void:
	if enemy_.is_detecting_player != true:
		switch_state.emit(Idle)
	else:
		return
	pass

func handle_path() -> void:
	enemy_.target = enemy_.player_node

func navTimeout():
	parent.set_target()

func exit_state() -> void:
	navTimer.stop()
