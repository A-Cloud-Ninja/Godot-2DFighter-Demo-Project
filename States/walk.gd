extends State
class_name walk
var _n = "walk"
func enter(r:bool,prev:String):
	super(r,prev)
	if not r and (prev == "idle"):
		#print(prev)
		var force = max(abs(100*inputhandler.direction.x),25)
		if inputhandler.direction.x < 0:
			force = -force
		body.velocity.x = force

func exit():
	super()
	pass

func physics_update(delta):
	super(delta)
	if inputhandler.attackPress:
		Transitioned.emit(self,"jab")
		return
	var d = inputhandler.direction
	if d.x > 0:
		body.velocity.x += 1.5
	elif d.x < 0:
		body.velocity.x -= 1.5
	else:
		if body.is_on_floor():
			if abs(body.velocity.x) < 15:
				update_sprite_flip()
				#print("back to idle")
				Transitioned.emit(self,"idle")
				return
	if inputhandler.jumpPress:
		Transitioned.emit(self,"jumpsquat")
		return
	if abs(body.velocity.x) < 10:
		update_sprite_flip()

func update(delta):
	super(delta)
	pass
