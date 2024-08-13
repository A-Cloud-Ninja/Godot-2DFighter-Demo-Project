extends Node
@onready var direction : Vector2
@onready var jumpPress: bool = false
@onready var jumpHeld: bool = false
@onready var attackPress: bool = false
@onready var attackHeld: bool = false
@onready var specialPress: bool = false
@onready var specialHeld: bool = false
@export var jsleft: String
@export var jsright: String
@export var jsup: String
@export var jsdown: String
@export var attack: String
@export var _jump: String
@export var special: String
func _physics_process(delta):
	jumpPress = Input.is_action_just_pressed(_jump)
	jumpHeld = Input.is_action_pressed(_jump)
	attackPress = Input.is_action_just_pressed(attack)
	attackHeld = Input.is_action_pressed(attack)
	specialPress = Input.is_action_just_pressed(special)
	specialHeld = Input.is_action_pressed(special)
	var dir = Input.get_vector(jsleft,jsright,jsup,jsdown)
	var out = Vector2(0,0)
	if abs(dir.x) > 0.1:
		out.x = dir.x
	if abs(dir.y) > 0.1:
		out.y = dir.y
	direction = out
