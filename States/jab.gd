extends State
class_name jab

@onready var lastframe = 0
@onready var hitboxes = []
@onready var index = 0
func enter(r:bool,prev:String):
	super(r,prev)
	lastframe = 0
	hitboxes = []

func exit():
	super()

func physics_update(delta):
	super(delta)

func update(delta):
	super(delta)
