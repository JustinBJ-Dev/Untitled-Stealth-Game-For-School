class_name Item extends CharacterBody2D

@export var friction : float
@export var speed : float

@onready var hitbox : HitBox = $HitBox

var health : int = 5

var pickedUp : bool = false
var pickUp_Point : Marker2D
var direction : Vector2

var sound : Sound


func _process(delta: float) -> void:
	if pickUp_Point == null:
		pickUp_Point = get_tree().get_first_node_in_group("pick_up_point")

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	
	if pickedUp:
		if pickUp_Point != null:
			self.global_transform = pickUp_Point.global_transform
			hitbox.disabled = true
	else:
		if velocity.length() <= 50:
			hitbox.disabled = true
			if health == 0:
				queue_free()
				
		else:
			hitbox.disabled = false
			pass
	
	velocity = velocity.lerp(Vector2(0,0), friction)
	
	if collision:
		if !pickedUp:
			sound = Sound.new()
			sound.global_position = self.global_position
			add_sibling(sound)
		
		if health >= 0:
			velocity = velocity.bounce(collision.get_normal())
		else:
			queue_free()

func throw():
	direction = Vector2(cos(rotation),sin(rotation)).normalized()
	velocity = speed * direction
	
	health -= 1
	
	pickedUp = false
