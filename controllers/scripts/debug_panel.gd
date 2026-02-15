extends PanelContainer

var framesPerSecond
var property
@onready var property_container = %VBoxContainer

func _ready():
	if not is_multiplayer_authority(): return
	visible = false
	Global.debug = self
	

func _process(delta):
	if not is_multiplayer_authority(): return
	if visible:
		addProperty("FPS", framesPerSecond, 1)
		framesPerSecond = "%.2f" % (1.0/delta)

func _input(event):
	if not is_multiplayer_authority(): return
	#toggle Debug Menu
	if event.is_action_pressed("debug"):
		visible = !visible

func addProperty(title: String, value, order):
	if not is_multiplayer_authority(): return
	var target
	target = property_container.find_child(title,true,false)
	if !target:
			target = Label.new()
			property_container.add_child(target)
			target.name = title
			target.text = target.name + ": " +  str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target,order)

#func addDebugProperty(title : String, value):
	#property = Label.new()
	#property_container.add_child(property)
	#property.name = title
	#property.text = property.name + value
