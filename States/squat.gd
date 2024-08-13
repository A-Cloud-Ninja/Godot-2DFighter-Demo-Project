extends State
class_name squat
func enter(r:bool,prev:String):
	super(r,prev)
	#sprite.connect("animation_finished",func(): Transitioned.emit(self,"crouched"))

func exit():
	super()
	pass

func physics_update(delta):
	super(delta)

func update(delta):
	super(delta)
