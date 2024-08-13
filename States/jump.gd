extends State
class_name jump
@onready var jumps = 2
@export var max_jumps = 2
func enter(r:bool,prev:String):
	if body.is_on_floor():
		jumps = max_jumps
	if jumps > 0:
		super(r,prev)
		jumps -= 1
		body.velocity.y = -300

func exit():
	super()
	pass

func physics_update(delta):
	super(delta)
	var d = inputhandler.direction
	if d.x > 0:
		body.velocity.x += 1.5
	elif d.x < 0:
		body.velocity.x -= 1.5
	if body.is_on_floor():
		Transitioned.emit(self,"land")
		return
	if inputhandler.jumpPress:
		Transitioned.emit(self,"jump")
		return
func update(delta):
	super(delta)
	pass
