class_name Item extends CharacterBody2D

@export var friction : float
@export var speed : float

var pickedUp : bool = false
var pickUp_Point : Marker2D
var direction : Vector2

func _process(delta: float) -> void:
	if pickUp_Point == null:
		pickUp_Point = get_tree().get_first_node_in_group("pick_up_point")

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if pickedUp:
		if pickUp_Point != null:
			self.global_transform = pickUp_Point.global_transform
	
	velocity = velocity.lerp(Vector2(0,0), friction)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func throw():
	direction = Vector2(cos(rotation),sin(rotation)).normalized()
	velocity = speed * direction
	
	
	pickedUp = false
