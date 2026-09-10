class_name SoundArea extends Area2D

signal heard_sound (vect)

func _process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("soundmaker"):
		if i is Sound:
			if !i.emit_sound.is_connected(check_for_sound):
				i.emit_sound.connect(check_for_sound)

func check_for_sound(sound) -> void:
	for i in get_overlapping_areas():
		if sound == i && sound is Sound:
			emit_signal("heard_sound", sound)
	pass
