extends EnemyState

var navTimer : Timer
var lookTimer : Timer
var target_point : Marker2D

var at_point : bool = false

@export_category("Properties")
@export var enemy_speed : int = 100
@export var naviagation_timer_wait_time : float = 0.1
@export var look_timer_wait_time : float = 2

@export_category("States")
@export var Chasing : State
@export var FollowPath : State

func _ready() -> void:
	enemy_.navigating = true
	
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	
	lookTimer = Timer.new()
	lookTimer.set_wait_time(look_timer_wait_time)
	add_child(lookTimer)
	lookTimer.timeout.connect(lookTimeout)
	
	target_point = Marker2D.new()
	add_child(target_point)

func enter_state() -> void:
	navTimer.start()
	enemy_.SPEED = enemy_speed

func physics_update(_delta: float) -> void:
	enemy_.visual.look_at(enemy_.global_position + enemy_.velocity)
	is_detecting_player()
	detect_is_at_point()

func  detect_is_at_point() -> void:
	
	
	if !at_point:
		if enemy_.global_position.distance_to(target_point.global_position) <= 64:
			enemy_.navigating = false
			enemy_.reset_velocity()
			look_around()
			lookTimer.start()
			at_point = true

func look_around() -> void:
	var rotation_tween = get_tree().create_tween()
	
	rotation_tween.tween_property(enemy_.visual, "rotation", enemy_.visual.rotation + 2*(PI), look_timer_wait_time)
	pass

func is_detecting_player() -> void:
	if enemy_.is_detecting_player == true:
		switch_state.emit(Chasing)

func heard_sound(sound : Sound) -> void:
	target_point.global_position = sound.global_position
	print(sound)
	pass

func handle_path() -> void:
	enemy_.target = target_point

func navTimeout() -> void:
	handle_path()
	enemy_.set_target()

func lookTimeout() -> void:
	switch_state.emit(FollowPath)

func exit_state() -> void:
	at_point = false
	lookTimer.stop()
	navTimer.stop()
