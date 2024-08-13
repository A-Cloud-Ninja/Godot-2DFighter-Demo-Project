extends State
class_name idle
@onready var _n = "idle"

func enter(r:bool,prev:String):
	super(r,prev)

func exit():
	super()
	pass

func physics_update(delta):
	super(delta)
	if inputhandler.attackPress:
		Transitioned.emit(self,"jab")
		return
	if inputhandler.jumpPress:
		Transitioned.emit(self,"jumpsquat")
		return
	var d = inputhandler.direction
	update_sprite_flip()
	if abs(d.x) > 0:
		Transitioned.emit(self,"walk")
		return
	if d.y > 0.25:
		Transitioned.emit(self,"squat")

func update(delta):
	super(delta)
	pass
