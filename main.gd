extends Node2D
@onready var g1 = $Granite
@onready var g2 = $Granite2

@onready var last_hit
@onready var last_attr


func _ready():
	var sm1 = g1.get_node("StateMachine")
	var sm2 = g2.get_node("StateMachine")
	var t = [g1,g2]
	for i in t:
		var sm = i.get_node("StateMachine")
		sm.connect("DAMAGE",damage)
		sm.connect("HURT",func(): hurt(i) )


func check():
	if last_hit and last_attr:
		last_hit.velocity = Vector2(last_attr.x,last_attr.y)
		print("APPLIED: ",last_attr)
		last_hit = false
		last_attr = false
		
	pass



func hurt(n):
	last_hit = n
	check()
func damage(attr):
	last_attr = attr
	check()



func _physics_process(delta):
	return
