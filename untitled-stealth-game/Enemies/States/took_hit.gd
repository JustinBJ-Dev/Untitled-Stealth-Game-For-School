extends EnemyState

var stateTimer : Timer
var visualTimer : Timer

@export var visual_timer_wait_time : float = 0.25
@export var state_timer_wait_time : float = 3

@export var visuals : Node2D
@export var hitbox : HitBox

@export var FollowPath : State

func _ready() -> void:
	stateTimer = Timer.new()
	stateTimer.set_wait_time(state_timer_wait_time)
	add_child(stateTimer)
	stateTimer.timeout.connect(stateTimer_Timeout)
	
	visualTimer = Timer.new()
	visualTimer.set_wait_time(visual_timer_wait_time)
	add_child(visualTimer)
	visualTimer.timeout.connect(visualTimer_Timeout)

func enter_state() -> void:
	visualTimer.start()
	stateTimer.start()
	
	enemy_.navigating = false
	enemy_.velocity *= 0
	
	call_deferred("disable_collision")

func disable_collision() -> void:
	hitbox.disabled = true
	enemy_.set_collision_layer_value(2, false)
	enemy_.set_collision_mask_value(1, false)

func update(delta: float) -> void:
	enemy_.is_detecting_player = false

func visualTimer_Timeout() -> void:
	if visuals.visible == true:
		visuals.visible = false
	elif visuals.visible == false:
		visuals.visible = true
	pass

func stateTimer_Timeout() -> void:
	switch_state.emit(FollowPath)
	pass

func exit_state() -> void:
	enemy_.set_collision_layer_value(2, true)
	enemy_.set_collision_mask_value(1, true)
	enemy_.navigating = true
	hitbox.disabled = false
	
	visualTimer.stop()
	stateTimer.stop()
	visuals.visible = true
