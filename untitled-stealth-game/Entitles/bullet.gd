extends HitBox

const SPEED: float = 1100.0
var area_direction = Vector2(0, 0)

@export var timer_Waittime: float = 100

var timer: int = 0

func _ready():
	attack.attack_damage  = attackDamage

func _process(delta):
	timer += 1
	self.translate(area_direction * SPEED * delta)
	
	if timer > timer_Waittime:
		queue_free()

func _on_body_entered(body):
	queue_free()

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage(attack)
