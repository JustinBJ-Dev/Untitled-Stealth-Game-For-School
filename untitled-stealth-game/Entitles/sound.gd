class_name Sound extends Area2D


signal emit_sound(sound)

var sound_vfx_texture = "res://Art/sound_vfx.png"
var sound_sprite : Sprite2D

var area : CollisionShape2D
var circle : CircleShape2D
var timer : Timer

func _ready() -> void:
	self.set_collision_layer_value(9, true)
	self.add_to_group("soundmaker")
	
	timer = Timer.new()
	timer.set_wait_time(0.25)
	add_child(timer)
	timer.timeout.connect(timeout)
	timer.start()
	
	circle = CircleShape2D.new()
	circle.radius = 10
	
	area = CollisionShape2D.new()
	add_child(area)
	area.set_shape(circle)
	
	sound_sprite = Sprite2D.new()
	sound_sprite.texture = load(sound_vfx_texture)
	add_child(sound_sprite)
	
	emit_signal("emit_sound", self)

func timeout() -> void:
	emit_signal("emit_sound", self)
	queue_free()
