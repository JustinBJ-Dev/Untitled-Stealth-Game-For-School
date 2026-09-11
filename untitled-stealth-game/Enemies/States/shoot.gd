extends EnemyState

var line : Line2D

var enemyPoint : Vector2
var targetPoint : Vector2

var cooldownTimer : Timer
@export var cooldown_timer_wait_time : float = 2

var blinks : int = 0
var start_visuals : bool = true
var visualTimer : Timer
@export var visual_timer_wait_time : float = 0.25


@export_category("Shooting")
@export var Bullet: PackedScene

@export var numberOf_Shots: int
@export var timeBetween_Shots: int
@export var shotDamage: float

var timer: int
var shotsLeft: int = 0
var canShoot : bool = false

var direction

@export_category("States")
@export var Search : State

func _ready() -> void:
	line = Line2D.new()
	add_child(line)
	line.modulate = Color(0.0, 0.431, 1.0)
	line.width = 3
	
	cooldownTimer = Timer.new()
	cooldownTimer.set_wait_time(cooldown_timer_wait_time)
	add_child(cooldownTimer)
	cooldownTimer.timeout.connect(cooldownTimeout)
	
	visualTimer = Timer.new()
	visualTimer.set_wait_time(visual_timer_wait_time)
	add_child(visualTimer)
	visualTimer.timeout.connect(visualTimer_Timeout)

func enter_state() -> void:
	enemy_.target = enemy_.player_node
	
	enemyPoint = enemy_.global_position
	targetPoint = enemy_.target.global_position
	
	line.add_point(enemyPoint)
	
	blinks = 0
	shotsLeft = 0
	canShoot = false
	start_visuals = true
	pass

func update(delta: float) -> void:
	enemy_.visual.look_at(targetPoint)
	line.clear_points()
	
	
	line.add_point(enemyPoint)
	line.add_point(targetPoint)
	
	enemyPoint = enemy_.global_position
	targetPoint = enemy_.target.global_position
	
	timer += 1
	if enemy_.is_detecting_player == false:
		switch_state.emit(Search)
		
	

func physics_update(delta: float) -> void:
	direction = (targetPoint - enemyPoint).normalized()
	
	if shotsLeft > 0 && canShoot == true:
		if timer >= timeBetween_Shots:
			shoot()
			start_visuals = true
	elif shotsLeft <= 0:
		if start_visuals == true:
			blinks = 0
			visualTimer.start()
			canShoot = false
			start_visuals = false
	
	pass

func shoot() -> void:
	var temp = Bullet.instantiate()
	timer = 0
	shotsLeft -= 1
	temp.set("attackDamage", shotDamage)
	temp.set("timer_Waittime", 100)
	temp.set("global_position", enemy_.global_position)
	temp.set("area_direction", direction)
	temp.set("rotation", enemy_.rotation)
	temp.set_collision_layer_value(1, false)
	temp.set_collision_layer_value(2, true)
	temp.set_collision_mask_value(1, true)
	enemy_.add_sibling(temp)

func cooldownTimeout() -> void:
	shotsLeft = numberOf_Shots
	pass

func visualTimer_Timeout() -> void:
	if blinks < 4:
		if line.visible == true:
			line.visible = false
		elif line.visible == false:
			line.visible = true
		start_visuals = false
		blinks += 1
	else:
		cooldownTimer.start()
		line.visible = true
		canShoot = true
		visualTimer.stop()
	pass

func exit_state() -> void:
	timer = 0
	shotsLeft = 0
	line.clear_points()
	pass
