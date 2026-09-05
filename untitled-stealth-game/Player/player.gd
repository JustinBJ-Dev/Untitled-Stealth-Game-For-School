class_name  player extends CharacterBody2D

var dirX: float
var dirY: float
var playerInput  : Vector2
var playerDirection : Vector2

var playerHealth : float = 3.0
var playerEnergy : float = 100

@export var healthBar : ProgressBar
@export var energyBar : ProgressBar

func _process(_delta):
	dirX = Input.get_axis("input_left", "input_right")
	dirY = Input.get_axis("input_up", "input_down")
	playerInput.x = dirX
	playerInput.y = dirY
	playerInput = playerInput.normalized()
	playerDirection = Vector2(cos(rotation),sin(rotation)).normalized()
	
	if Input.is_action_just_pressed("ui_accept"):
		playerEnergy -= 100
	
	manage_ui()

func manage_ui() -> void:
	healthBar.value = playerHealth
	energyBar.value = playerEnergy
	pass

func _physics_process(_delta: float) -> void:
	self.look_at(global_position + velocity)
	
	move_and_slide()
