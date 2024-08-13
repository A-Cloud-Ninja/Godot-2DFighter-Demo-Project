extends Node
class_name State
signal Transitioned
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var inputhandler = get_parent().input_handler
@export var animplayer:AnimationPlayer
@export var body:CharacterBody2D
@export var sprite:AnimatedSprite2D
@export var max_speed:float
@export var cancel_to: String
@export var hbh:Node2D

func update_sprite_flip():
	var d = inputhandler.direction
	if d.x > 0:
		sprite.scale.x = 1
	elif d.x < 0:
		sprite.scale.x = -1


func enter(r:bool,prev:String):
	sprite.stop()
	sprite.play(self.name.to_lower())
func exit():
	for child in hbh.get_children():
		child.queue_free()
func update(_delta: float):
	if sprite.frame_progress == 1:
		Transitioned.emit(self,cancel_to)

func physics_update(_delta: float):
	if not body.is_on_floor():
		body.velocity.y += gravity * _delta
		if body.velocity.x > 0:
			body.velocity.x -=1.5
		elif body.velocity.x < 0:
			body.velocity.x +=1.5
	else:
		if body.velocity.x > 0:
			body.velocity.x -= 1
		elif body.velocity.x < 0:
			body.velocity.x += 1
	if abs(body.velocity.x) > max_speed:
		if body.velocity.x > 0:
			body.velocity.x = max_speed
		else:
			body.velocity.x = -max_speed
	body.move_and_slide()



