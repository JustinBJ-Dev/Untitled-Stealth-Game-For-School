extends EnemyState

@export_category("Properties")
@export var enemy_speed : int = 100
@export var naviagation_timer_wait_time : float = 0.1
@export var dashing_timer_wait_time : float = 5

@export var detectionCast : RayCast2D
@export var dashingArea : Area2D
@export_category("States")
@export var Idle : State
@export var Dashing : State

var navTimer : Timer

var dashTimer : Timer
var can_dash : bool = false

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)

func enter_state() -> void:
	enemy_.SPEED = enemy_speed
	enemy_.target = enemy_.player_node
	navTimer.start()
	
	dashTimer = Timer.new()
	dashTimer.set_wait_time(dashing_timer_wait_time)
	add_child(dashTimer)
	dashTimer.timeout.connect(dashTimeout)
	dashTimer.start()
	
	pass

func physics_update(_delta: float) -> void:
	is_detecting_player()
	
	if can_dash == true:
		if enemy_.is_detecting_player == true:
			for i in dashingArea.get_overlapping_areas():
				if i.is_in_group("player") == true:
					switch_state.emit(Dashing)

func is_detecting_player() -> void:
	if enemy_.is_detecting_player != true:
		switch_state.emit(Idle)
	else:
		return
	pass

func handle_path() -> void:
	enemy_.target = enemy_.player_node

func navTimeout() -> void:
	parent.set_target()

func dashTimeout() -> void:
	can_dash = true
	pass

func exit_state() -> void:
	can_dash = false
	navTimer.stop()
	
	dashTimer.queue_free()
