class_name HurtBox extends Area2D

signal tookHit(hit: Attack)

@export var hitExceptions: Array

func damage(attack: Attack):
	print(attack)
	tookHit.emit(attack)
