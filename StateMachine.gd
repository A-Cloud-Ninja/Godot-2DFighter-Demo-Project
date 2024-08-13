extends Node
@export var initial_state : State
@export var input_handler : Node
@export var box_manager : Node
@onready var last_attr = {}
var current_state : State
var states : Dictionary = {}
signal DAMAGE(attr)
signal HURT()

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
		if initial_state:
			initial_state.enter(false,"idle")
			current_state = initial_state
	box_manager.connect("interact",on_hitbox_interaction)
	box_manager.connect("damage",
		func(attr):
			last_attr = attr
			DAMAGE.emit(last_attr)
	)
	box_manager.connect("hurt",
		func():
			HURT.emit()
	)
	box_manager.state_change("idle")

func _process(delta):
	if current_state:
		current_state.update(delta)
		box_manager._back()

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_hitbox_interaction(current_state_name,new_state_name):
	var state = states.get(current_state_name.to_lower())
	if state:
		on_child_transition(state,new_state_name)


func on_child_transition(state,new_state_name):
	#print(state,new_state_name,current_state)
	if state != current_state:
		print("state not eq",state,current_state)
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("no new state?")
		return
	if current_state:
		current_state.exit()
	var current_name = current_state.name.to_lower()
	var r = false
	if current_name == new_state_name:
		r = true
	new_state.enter(r,current_name)
	box_manager.state_change(new_state_name)
	current_state = new_state
