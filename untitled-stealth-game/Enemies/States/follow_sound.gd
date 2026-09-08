extends EnemyState

var navTimer : Timer
var target_point : Marker2D

@export_category("Properties")
@export var enemy_speed : int = 100
@export var naviagation_timer_wait_time : float = 0.1

@export_category("States")
@export var Chasing : State
@export var FollowPath : State

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	
	target_point = Marker2D.new()
	add_child(target_point)

func enter_state() -> void:
	
	pass

func navTimeout() -> void:
	handle_path()
	enemy_.set_target()

func handle_path() -> void:
	enemy_.target = target_point

func _process(delta: float) -> void:
	pass
