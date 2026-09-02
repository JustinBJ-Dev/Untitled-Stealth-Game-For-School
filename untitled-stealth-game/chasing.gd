extends State

var navTimer : Timer

func enter_state() -> void:
	navTimer = Timer.new()
	navTimer.set_wait_time(0.5)
	add_child(navTimer)
	navTimer.timeout.connect(navTimeout)
	navTimer.start()
	pass


func navTimeout():
	parent.set_target()

func exit_state() -> void:
	navTimer.queue_free()
