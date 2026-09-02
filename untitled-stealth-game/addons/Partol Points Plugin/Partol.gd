@tool
extends Line2D

@export var debug : bool
var Logic_Scene : PackedScene = preload("partol_logic.tscn")

func _enter_tree():
	width = 5.0
	
	if Engine.is_editor_hint():
		var LogicScene = Logic_Scene.instantiate()
		
		if get_child_count() < 1:
			add_child(LogicScene)
			LogicScene.set_owner(get_tree().get_edited_scene_root())
		pass
	
	if !Engine.is_editor_hint() && !debug:
		default_color = Color(255, 255, 255, 0)
	pass

func _process(delta):
	pass
