extends EnemyState

@export_category("States")
@export var Idle : State
@export var detectionCast : RayCast2D

var navTimer : Timer

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(0.5)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)

func enter_state() -> void:
	navTimer.start()
	
	enemy_.target = enemy_.player_node
	pass

func physics_update(delta: float) -> void:
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
