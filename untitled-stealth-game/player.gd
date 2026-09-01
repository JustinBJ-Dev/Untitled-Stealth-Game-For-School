class_name  player extends CharacterBody2D

var dirX: float
var dirY: float

var playerInput  : Array

func _process(delta):
	dirX = Input.get_axis("input_left", "input_right")
	dirY = Input.get_axis("input_up", "input_down")
	

func _physics_process(delta: float) -> void:
	self.look_at(global_position + velocity)
	
	move_and_slide()
