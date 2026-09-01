extends CharacterBody2D

@export var nav2d : NavigationAgent2D
@export var target : Node2D
var navTimer : Timer

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(0.5)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	navTimer.start()
	
	set_target()

func _physics_process(delta: float) -> void:
	navigation(delta)
	move_and_slide()

func set_target() -> void:
	nav2d.target_position = target.global_position

func navigation(delta) -> void:
	if nav2d.is_navigation_finished():
		return
	var next_path_position: Vector2 = nav2d.get_next_path_position()
	velocity = (
		global_position.direction_to(next_path_position) * 100
	)
	pass

func navTimeout():
	set_target()
