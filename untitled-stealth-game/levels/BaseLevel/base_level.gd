extends Node2D

var stars_collected : int = 0
var max_stars : int = 3
var stars : Array

@export var door : Door
@export var background : Sprite2D

@export var NextScene: StringName = &"FILL ME"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelStats.current_stars = 0
	background.visible = true
	
	door.levelFinished.connect(change_scene)
	
	for i in get_children():
		if i is Star:
			stars.append(i)
			i.star_collected.connect(new_star_collected)

func new_star_collected() ->void:
	stars_collected += 1
	LevelStats.overall_stars += 1
	LevelStats.current_stars = stars_collected
	
	if stars_collected == max_stars - 1:
		door.open()

func change_scene() -> void:
	print("Level")
	SceneLoader.load_scene(NextScene)
	pass
