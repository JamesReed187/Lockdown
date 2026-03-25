@tool

extends Node

@export var is_frozen: bool = false

func un_frozen(frozen: bool):
	is_frozen = frozen
	if not is_frozen:
		Player.process_mode = Node.PROCESS_MODE_INHERIT
		print("player_is_unfrozen")


var player
var playerPoints = 0:
	set(value):
		playerPoints = value
		updatePoints()
var playerHealth = 100:
	set(value):
		healthLabel.text = str(value)
		playerHealth = value
var playerCamera
var debug
var weaponManager
var reserveLabel : Label
var clipLabel : Label
var pointsLabel : Label
var healthLabel: Label
var interactionLabel: Label

var myCurrentTeam : String

func updateLabels(clipAmmo, reserveAmmo):
	clipLabel.text = str(clipAmmo)
	reserveLabel.text = str(reserveAmmo)

func updatePoints():
	pointsLabel.text = str(playerPoints)

func updateHealth():
	#DEPRECATED FUNCTION but still here for old code
	healthLabel.text = str(playerHealth)

# if status is true, increases the size of the window and scales on-screen elements to window size
# allows for better viewing on retina (or similar resolution) displays
func high_resolution_display_mode(status):
	if status == true:
		if OS.get_name()=="macOS": # Checks if MacOS. Unsure if required.
			print("resizine window")
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT # scales UI elements to window size.
			DisplayServer.window_set_size(Vector2i(2560, 1440)) # Sets windows dimensions
			get_window().move_to_center() # Centres the screen

# Called when the node enters the scene tree for the first time.
func _ready():
	high_resolution_display_mode(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

@rpc("any_peer", "reliable")
func replicateSpecificObject(bodyName, function, arg1):
	var object = get_tree().get_root().get_node(bodyName)
	if arg1:
		object.call(function, arg1)
	else:
		object.call(function)
	

#This function is for adding things to in game debug menu
#Format:
#Global.debug.addProperty("Display Name", Variable, Position on debug board)

#Example formatting
#Global.debug.addProperty("Stamina", stamina, 2)
