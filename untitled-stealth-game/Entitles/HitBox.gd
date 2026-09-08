class_name HitBox extends Area2D

var attack: Attack = Attack.new()

@export var attackDamage: int: set = _set_damage, get = _get_damage
@export var attackKnockback: int: set = _set_knockboack, get = _get_knockback
@export var hitExceptions: Array

@export var disabled: bool = false : set = _set_disabled_, get = _is_disabled

func _ready():
	attack.attack_damage  = attackDamage
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	for hit in hitExceptions:
		if area == get_node(hit):
			return
	
	if area is HurtBox:
		area.damage(attack)

func _set_damage(amount : int):
	attackDamage = amount
	attack.attack_damage  = attackDamage
	pass

func _get_damage():
	return attackDamage

func _set_knockboack(amount : int):
	attackKnockback = amount
	attack.attack_knockback  = attackKnockback
	pass

func _get_knockback():
	return attackKnockback

func _set_disabled_(value : bool):
	if value == false:
		for i in get_children():
			if i is CollisionShape2D:
				i.disabled = false
			if i is CollisionPolygon2D:
				i.disabled = false
	elif value == true:
		for i in get_children():
			if i is CollisionShape2D:
				i.disabled = true
			if i is CollisionPolygon2D:
				i.disabled = true
	pass

func _is_disabled() -> bool:
	return disabled
