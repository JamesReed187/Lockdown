extends Node3D

@export var teamFilter = "Both"
@export var objectName : String = ""
#@onready var deathcube = $DeathCube
var deathcube
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#deathcube = get_node("/root/DeathCube")
	deathcube = get_tree().current_scene.get_node("DeathCube")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact():
	print ("AAAAAA")
	#print(deathcube.name)
	deathcube.becomeDangerous()
	
func update():
	pass
