extends Node2D

var stars_collected : int = 0
var max_stars : int = 3
var stars : Array

@export var door : Door
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Star:
			stars.append(i)
			i.star_collected.connect(new_star_collected)

func new_star_collected() ->void:
	stars_collected += 1
	
	if stars_collected == max_stars - 1:
		door.open()
