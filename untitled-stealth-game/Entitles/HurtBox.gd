class_name HurtBox extends Area2D

signal tookHit(hit: Attack)

@export var hitExceptions: Array

func _ready() -> void:
	self.area_entered.connect(area_entered_hurtbox)
	pass

func damage(attack: Attack):
	tookHit.emit(attack)

func area_entered_hurtbox(Area):
	if Area is HitBox:
		tookHit.emit(Area.attack)
