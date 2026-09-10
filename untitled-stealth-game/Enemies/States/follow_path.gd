extends EnemyState

var navTimer : Timer
var target_point : Marker2D

var partolPath : Partol_Path
var onPath : bool #Whether you're on path or not
var pathPosition : Vector2 #Last point you were on path

var current_point_position : Vector2 #Contains the position of the current point
var current_point_number : int = 0 #Contains the current point on the path
var next_point_number : int #Contains the next point on the path

var rotationTimer : Timer
var rotationTime : float = 1
var rotating : bool = false
var kill_rotation : bool = false

@export_category("Properties")
@export var enemy_speed : int = 100
@export var naviagation_timer_wait_time : float = 0.1

@export_category("States")
@export var Chasing : State
@export var FollowSound : State

func _ready() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(naviagation_timer_wait_time)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	
	
	rotationTimer = Timer.new()
	rotationTimer.set_wait_time(rotationTime)
	add_child(rotationTimer)
	
	target_point = Marker2D.new()
	add_child(target_point)
	
	partolPath = enemy_.partol_path
	partolPath.get_path_points()
	
	
	pass

func enter_state() -> void:
	enemy_.navigating = true
	navTimer.start()
	kill_rotation = false
	enemy_.SPEED = enemy_speed
	
	determine_path_on_enter()

func determine_path_on_enter() -> void: #If the last position on the path is closer than the closet point, the enemy will go the last position on the graph.
	if enemy_.global_position.distance_to(pathPosition) >= enemy_.global_position.distance_to(partolPath.get_point_position(partolPath.get_closest_point(enemy_.global_position))):
		current_point_number = partolPath.get_closest_point(enemy_.global_position)
		current_point_position = partolPath.get_point_position(current_point_number)
		next_point_number = partolPath.get_next_point(current_point_number)
		pathPosition = current_point_position

func physics_update(_delta: float) -> void:
	
	is_detecting_player()
	
	detect_is_on_path()
	set_path_position()
	detect_is_at_point()
	
	if onPath != true:
		enemy_.visual.look_at(enemy_.global_position + enemy_.velocity)

func detect_is_on_path() -> void: #Detects if the enemy is current on the path
	if enemy_.global_position.distance_to(pathPosition) <= 10:
		onPath = true
	else:
		onPath = false

func set_path_position() -> void: #Sets the pathPosition as the current_point_position if the enemy is onPath
	if onPath:
		current_point_position = partolPath.get_point_position(current_point_number)
		pathPosition = enemy_.global_position

func  detect_is_at_point() -> void: #Detect if the enemy is at a the current point, and sets next point if it is
	if enemy_.global_position.distance_to(current_point_position) <= 10:
		current_point_number = next_point_number
		
		if onPath:
			enemy_.navigating = false
			enemy_.reset_velocity()
			await  rotate_path()
			if rotating == false:
				enemy_.reset_velocity()
				enemy_.navigating = true
				rotating = false
		
		next_point_number = partolPath.get_next_point(current_point_number)

func rotate_path():
	print("Rotating: ", rotating, "\nKill rotation: ", kill_rotation)
	
	var direction = enemy_.global_position.direction_to(partolPath.get_point_position(current_point_number))
	direction = direction.angle()
	var dir_angle = lerp_angle(enemy_.visual.rotation, direction, 1)
	
	if abs(dir_angle) - abs(enemy_.visual.rotation) >= 0.5 || abs(dir_angle) - abs(enemy_.visual.rotation) <= -0.5:
		var rotation_tween = get_tree().create_tween()
		if rotating == false:
			rotating = true
			rotation_tween.tween_property(enemy_.visual, "rotation", dir_angle, rotationTime)
			await  rotation_tween.finished
			rotating = false
			return
	else:
		enemy_.visual.rotation = direction
		
		return
	pass

func heard_sound(sound : Sound) -> void:
	switch_state.emit(FollowSound)
	pass

func navTimeout():
	handle_path()
	enemy_.set_target()

func handle_path() -> void:
	if onPath:
		target_point.global_position = current_point_position
	else:
		target_point.global_position = pathPosition
	
	enemy_.target = target_point

func is_detecting_player() -> void:
	if enemy_.is_detecting_player == true:
		switch_state.emit(Chasing)

func exit_state() -> void:
	navTimer.stop()
	rotationTimer.stop()
	rotating = false
	onPath = false
	kill_rotation = true
	rotate_path()
