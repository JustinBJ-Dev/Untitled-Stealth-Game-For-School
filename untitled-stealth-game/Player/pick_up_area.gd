extends Area2D

@onready var pickUp_Point: Marker2D
var itemPickedUp : bool = false

var item : Item
var hasitem : bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("input_interact"):
		if itemPickedUp == false:
			pick_up()
		elif  itemPickedUp == true:
			throw()
	pass

func pick_up() -> void:
	for i in get_overlapping_bodies():
		if i is Item:
				i.pickUp_Point = pickUp_Point
				i.pickedUp = true
				itemPickedUp = true
				item = i
		pass

func throw() -> void:
	
	item.throw()
	itemPickedUp = false
	pass
