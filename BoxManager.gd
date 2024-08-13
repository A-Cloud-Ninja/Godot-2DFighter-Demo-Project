extends State
@onready var hitboxes = []
@onready var lastframe = 0
@onready var index = 0
@onready var current_state = "idle"
@export var __framedata:JSON
@onready var framedata = __framedata.data
@onready var attr_lookup = {}



signal interact(current,new)
signal damage(attr)
signal hurt()
#Hitboxes are layer-1 mask-1,2
#Hurtboxes are layer-2 mask-1,2
#bodies for collision are >=29
func _ready():
	pass
func _back():
	var frame = sprite.frame
	if framedata.keys().has(current_state):
		if framedata[current_state].keys().has(str(frame)) and lastframe < frame:
			var boxes = framedata[current_state][str(frame)]
			lastframe = frame
			for box in boxes:
				var _b: Area2D
				var _box = {id=index}
				if box.type == 0:
					_b = hitbox(box.x,box.y,box.width,box.height,0,0,0,box.time)
					attr_lookup[_b] = box.attr
				else:
					_b = hurtbox(box.x,box.y,box.width,box.height,0,0,0,box.time)
				var f = func():
					if sprite.frame == frame+box.time:
						hitboxes.erase(_box)
						_b.queue_free()
					return true
				_box.callable = f
				index+=1
				hitboxes.append(_box)
		for box in hitboxes:
			if box:
				var c: Callable = box.callable
				c.call()


func state_change(state):
	current_state = state
	for box in hitboxes:
		hitboxes.erase(box)
	for child in hbh.get_children():
		pass
		#child.queue_free()
	hitboxes = []
	lastframe = 0
	attr_lookup = {}
	

func new_area():
	var area = Area2D.new()
	var t = Timer.new()
	area.connect("area_entered",
		func(a:Area2D):
			if !a.get_parent() == hbh:
				#Active Detection Loop
				if area.collision_layer == 1 and a.collision_layer == 2:  #Attacked Other Player
					#print("A Hurtbox Has Intersected With This Hitbox")
					if attr_lookup.keys().has(area):
						var lu = attr_lookup[area].duplicate()
						print(lu)
						lu.x = lu.x * sprite.scale.x
						print(lu)
						damage.emit(lu)
						a.queue_free()
				elif area.collision_layer == 2 and a.collision_layer == 1:  #Attacked By Other Player
					hurt.emit()
					interact.emit(current_state,"hurt_weak")
				elif area.collision_layer == 2 and a.collision_layer == 2:  #Collided With Other Player
					pass
					#print("A Hurtbox Has Intersected With This Hurtbox")
				elif area.collision_layer == 1 and a.collision_layer == 1:  #Clanked With Other Player
					pass
					#print("A Hitbox Has Intersected With This Hitbox")
	)
	area.connect("body_entered",
		func(b):
			if !b.get_parent() == hbh:
				#Active Detection Loop
				if area.collision_layer == 1 and b.collision_layer == 2:
					pass
					#print("A Hurtbox Has Intersected With This Hitbox")
				elif area.collision_layer == 2 and b.collision_layer == 1:
					pass
					#print("A Hitbox Has Intersected With This Hurtbox")
				elif area.collision_layer == 2 and b.collision_layer == 2:
					pass
					#print("A Hurtbox Has Intersected With This Hurtbox")
				elif area.collision_layer == 1 and b.collision_layer == 1:
					pass
					#print("A Hitbox Has Intersected With This Hitbox")
	)
	return [area,t]

func new_collision(x,y,w,h):
	var pos = Vector2(x,y)
	var size = Vector2(w,h)
	var r = RectangleShape2D.new()
	r.size = size
	var coll = CollisionShape2D.new()
	coll.shape = r
	coll.position += pos
	return coll

func hitbox(x: float, y: float, w: float, h: float,damage:float,knockback:float,kbscaling:float,lifetime:float):
	var coll = new_collision(x,y,w,h)
	coll.debug_color = Color.CRIMSON
	var ret = new_area()
	var area: Area2D = ret[0]
	area.collision_mask = 1 + 2
	area.collision_layer = 1
	hbh.add_child(area)
	area.add_child(coll)
	return area

func hurtbox(x: float, y: float, w: float, h: float,damage:float,knockback:float,kbscaling:float,lifetime:float):
	var coll = new_collision(x,y,w,h)
	coll.debug_color = Color.CHARTREUSE
	var ret = new_area()
	var area: Area2D = ret[0]
	area.collision_mask = 1 + 2
	area.collision_layer = 2
	hbh.add_child(area)
	area.add_child(coll)
	return area
