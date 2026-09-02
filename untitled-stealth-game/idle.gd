extends EnemyState

var navTimer : Timer
var target_point : Marker2D

var partolPath : Partol_Path
var onPath : bool #Whether you're on path or not
var pathPosition : Vector2 #Last point you were on path

var current_point_position : Vector2 #Contains the position of the current point
var current_point_number : int = 0 #Contains the current point on the path
var next_point_number : int #Contains the next point on the path

func _ready() -> void:
	partolPath = enemy_.partol_path
	partolPath.get_path_points()
	pass

func enter_state() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(0.25)
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
	if enemy_.global_position.x >= pathPosition.x - 5 && enemy_.global_position.x <= pathPosition.x + 5:
		if enemy_.global_position.y >= pathPosition.y - 5 && enemy_.global_position.y <= pathPosition.y + 5:
			onPath = true
	
	if onPath:
		print(current_point_number)
		current_point_position = partolPath.get_point_position(current_point_number)
		pathPosition = current_point_position
	
	if enemy_.global_position.x >= current_point_position.x - 5 && enemy_.global_position.x <= current_point_position.x + 5: # -5<x<5  Check if the characters x value is within ten pixelx of the current_point_position.x 
		if enemy_.global_position.y >= current_point_position.y - 5 && enemy_.global_position.y <= current_point_position.y + 5: # -5<y<5  Check if the characters y value is within ten pixel of the current_point_position.x
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
