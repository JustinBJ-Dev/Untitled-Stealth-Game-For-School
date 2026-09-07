class_name HitBox extends Area2D

var attack: Attack = Attack.new()

@export var attackDamage: int: set = _set_damage, get = _get_damage
@export var attackKnockback: int: set = _set_knockboack, get = _get_knockback
@export var hitExceptions: Array

func _ready():
	attack.attack_damage  = attackDamage
	area_entered.connect(_on_area_entered)

func _on_area_entered(area):
	for hit in hitExceptions:
		if area == get_node(hit):
			return
	
	if area is HurtBox:
		print(area)
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
