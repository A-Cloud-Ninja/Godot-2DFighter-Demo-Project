extends State
class_name crouched
func enter(r:bool,prev:String):
	super(r,prev)

func exit():
	super()

func physics_update(delta):
	super(delta)
	var d = inputhandler.direction
	if d.y < 0.25:
		Transitioned.emit(self,"idle")
	if inputhandler.jumpPress:
		Transitioned.emit(self,"jumpsquat")
		return
	if inputhandler.attackPress:
		Transitioned.emit(self,"dtilt")
		return
	if inputhandler.specialPress:
		Transitioned.emit(self,"dspecial")

func update(delta):
	super(delta)
