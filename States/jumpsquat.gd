extends State
class_name jumpsquat
func enter(r:bool,prev:String):
	sprite.stop()
	sprite.play("squat")

func exit():
	super()
	pass

func physics_update(delta):
	super(delta)

func update(delta):
	super(delta)
