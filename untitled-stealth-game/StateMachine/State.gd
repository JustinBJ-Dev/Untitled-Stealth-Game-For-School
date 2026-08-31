class_name State extends Node

signal switch_state(state : State)
@export var parent : Node2D

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
