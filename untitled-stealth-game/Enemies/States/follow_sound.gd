extends EnemyState

var navTimer : Timer
var lookTimer : Timer
var waitTimer : Timer
var target_point : Marker2D

var rotation_tween : Tween

var at_point : bool = false
var start_following : bool = false

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
	
	waitTimer = Timer.new()
	waitTimer.set_wait_time(0.25)
	add_child(waitTimer)
	waitTimer.timeout.connect(waitTimeout)
	
	target_point = Marker2D.new()
	add_child(target_point)

func enter_state() -> void:
	enemy_.navigating = false
	enemy_.reset_velocity()
	at_point = false
	start_following = false
	navTimer.start()
	waitTimer.start()
	enemy_.SPEED = enemy_speed

func physics_update(_delta: float) -> void:
	if start_following == true:
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
	rotation_tween = get_tree().create_tween()
	
	rotation_tween.tween_property(enemy_.visual, "rotation", enemy_.visual.rotation + 2*(PI), look_timer_wait_time)
	pass

func is_detecting_player() -> void:
	if enemy_.is_detecting_player == true:
		switch_state.emit(Chasing)

func heard_sound(sound : Sound) -> void:
	target_point.global_position = sound.global_position
	pass

func handle_path() -> void:
	enemy_.target = target_point

func navTimeout() -> void:
	handle_path()
	enemy_.set_target()

func waitTimeout() -> void:
	start_following = true
	enemy_.navigating = true
	waitTimer.stop()

func lookTimeout() -> void:
	switch_state.emit(FollowPath)

func exit_state() -> void:
	if rotation_tween:
		rotation_tween.stop()
	lookTimer.stop()
	navTimer.stop()
