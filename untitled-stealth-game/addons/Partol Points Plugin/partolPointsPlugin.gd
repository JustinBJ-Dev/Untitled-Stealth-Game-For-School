@tool
extends EditorPlugin

var add_point_button = Button.new()

var sprite = Sprite2D.new()


func _enter_tree():
	add_custom_type("Partol", "Line2D", preload("Partol.gd"), preload("Path Follow Icon.png"))


func _exit_tree():
	remove_custom_type("Partol")
	pass

func _get_plugin_name():
	return "Partol"
