extends EnemyState

var navTimer : Timer
var target_point : Marker2D

var partolPath : Partol_Path
var onPath : bool #Whether you're on path or not
var pathPosition : Vector2 #Last point you were on path

var current_point_position : Vector2 #Contains the position of the current point
var current_point_number : int = 0 #Contains the current point on the path
var next_point_number : int #Contains the next point on the path

@export var naviagation_timer_wait_time : float = 0.1

@export_category("States")
@export var Chasing : State
@export var detectionCast : RayCast2D

func _ready() -> void:
	partolPath = enemy_.partol_path
	partolPath.get_path_points()
	pass

func enter_state() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	navTimer.start()
	
	target_point = Marker2D.new()
	add_child(target_point)
	
	current_point_number = partolPath.get_closest_point(enemy_.global_position)
	current_point_position = partolPath.get_point_position(current_point_number)
	next_point_number = partolPath.get_next_point(current_point_number)
	pathPosition = current_point_position

func physics_update(delta: float) -> void:
	
	detect_is_on_path()
	set_path_position()
	detect_is_at_point()

func detect_is_on_path() ->void: #Detects if the enemy is current on the path
	if enemy_.global_position.distance_to(pathPosition) <= 10:
		onPath = true

func set_path_position() -> void: #Sets the pathPosition as the current_point_position if the enemy is onPath
	if onPath:
		current_point_position = partolPath.get_point_position(current_point_number)
		pathPosition = enemy_.global_position

func  detect_is_at_point() -> void: #Detect if the enemy is at a the current point, and sets next point if it is
	if enemy_.global_position.distance_to(current_point_position) <= 10:
		current_point_number = next_point_number
		next_point_number = partolPath.get_next_point(current_point_number)

func navTimeout():
	handle_path()
	enemy_.set_target()

func handle_path() -> void:
	if onPath:
		target_point.global_position = current_point_position
	else:
		target_point.global_position = pathPosition
	
	enemy_.target = target_point

func exit_state() -> void:
	navTimer.queue_free()
	target_point.queue_free()
