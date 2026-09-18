extends Node3D

@onready var dropLocation = $"Item Spawn Location"
var rng = RandomNumberGenerator.new()
var weaponDrop = preload("res://Scenes/Weapon Drop.tscn")
var itemPaths = [
"res://Items/Item Files/Gem.tres",
"res://Items/Item Files/Goldbar.tres",
"res://Items/Item Files/Painting.tres"

]



func _ready() -> void:
	rng.randomize()
	Global.roundReset.connect(spawnItem)
	Global.playerJoined.connect(spawnItem)

func spawnItem():
	if multiplayer.get_unique_id() == 1:
		var dropInstance = weaponDrop.instantiate()
		var dropName = "Item Drop %d" % rng.randi_range(1, 10000)
		while find_child(dropName) != null:
			dropName = "Item Drop %d" % rng.randi_range(1, 10000)
		dropInstance.name = dropName
		get_tree().root.get_node("World").add_child(dropInstance)
		var loadedItem = itemPaths[rng.randi_range(0, itemPaths.size()-1)]
		dropInstance.global_position = dropLocation.global_position
		dropInstance.setWeapon(loadedItem)
		dropInstance.setModel(loadedItem)
		dropInstance.setAttribute("isItem", true)
		dropInstance.setName(dropName)
		get_tree().current_scene.totalItems += 1
		await get_tree().create_timer(1).timeout
		rpc("replicateDroppedItem", loadedItem, dropInstance.global_position, dropName)
	
@rpc("any_peer")
func replicateDroppedItem(weapon, dropPos, dropName):
	var dropInstance = weaponDrop.instantiate()
	dropInstance.setName(dropName)
	get_tree().root.get_node("World").add_child(dropInstance)
	dropInstance.global_position = dropPos
	dropInstance.setWeapon(weapon)
	dropInstance.setModel(weapon)
	dropInstance.setAttribute("isItem", true)
	get_tree().current_scene.totalItems += 1
