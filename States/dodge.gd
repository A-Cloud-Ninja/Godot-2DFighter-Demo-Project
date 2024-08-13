extends State
class_name Dodge
var _n = "dodge"
func enter(r,prev):
	super(r,prev)
	animplayer.play(_n)
	animplayer.connect("animation_finished",
		func(name):
			emit_signal("Transitioned",self,"idle")
	)
	pass

func exit():
	pass

func physics_update(delta):
	super(delta)

func update(delta):
	super(delta)
	pass
