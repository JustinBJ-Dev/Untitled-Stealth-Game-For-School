class_name enemy
extends CharacterBody2D

@export_category("Set Up Nodes")
@export var nav2d : NavigationAgent2D
@export var partol_path : Partol_Path
@export var target : Node2D
@export var detectionCast : RayCast2D
@export var detectionArea : Area2D
@export var visionCone : Node2D
@export_category("Propertires")
@export var SPEED : int = 100


var is_detecting_player : bool = false
var navTimer : Timer
var player_node : player

func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	
	visionCone.look_at(global_position + velocity)
	
	detectionCast.target_position = player_node.global_position - self.global_position
	detect_player()
	navigation(delta)
	move_and_slide()

func detect_player() -> void:
	if detectionCast.is_colliding() == true:
		if detectionCast.get_collider() == player_node:
			for i in detectionArea.get_overlapping_bodies():
				if i == player_node:
					is_detecting_player = true
		else:
			is_detecting_player = false

func set_target() -> void:
	nav2d.target_position = target.global_position

func navigation(_delta) -> void:
	if nav2d.is_navigation_finished():
		return
	var next_path_position: Vector2 = nav2d.get_next_path_position()
	velocity = (
		global_position.direction_to(next_path_position) * SPEED
	)

func navTimeout():
	set_target()
