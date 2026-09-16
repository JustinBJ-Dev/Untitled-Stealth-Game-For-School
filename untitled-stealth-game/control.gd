extends Control

@export var label : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = str(LevelStats.overall_stars) + "/9 Stars collected"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
