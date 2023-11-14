extends Node

# Define signals
signal upgradeStars(type:String, amount:int)
signal upgradeEnemies(type:String, amount:int)
signal upgradePlayer(type:String, amount:int)

func _ready():
	# Connect the signals to the handle_signal function
	upgradeStars.connect(_onUpgradeStars)



func catch_upgrade_call(upgrade):
	# upgrade = "masa
	var upgrade_data = UpgradeDb.df[upgrade]
	#{ "icon": "res://Assets/LevelCards/dash_ship.png", "player": true, "star": true, "display_name": "dash", "ammount": 1, "prerequisite": [] }
	# Check if the upgrade is for a star
	if upgrade_data["star"]:
		# Get all nodes in the 'Star' group
		var stars = get_tree().get_nodes_in_group("Star")
		# Iterate over the stars and upgrade each one
		if upgrade == "masa":
			for star in stars:
				star.upgrade_masa(upgrade_data["ammount"])  # Assumes 'Star' nodes have an 'upgrade' method
		elif upgrade == "rotacion":
			for star in stars:
				star.upgrade_rotacion(upgrade_data["ammount"])
		elif upgrade == "carga":
			for star in stars:
				star.upgrade_carga(upgrade_data["ammount"])
	

func _onUpgradeStars(type, amount):
	var star_nodes = get_nodes_from_type("Star")
	print("ComBus")
	print(star_nodes)
	
func handle_signal(type: String, amount: int):
	# Get all nodes in the group
	var nodes = get_nodes_from_type(type)

	# Iterate over the nodes
	for node in nodes:
		# Perform some action
		node.some_variable = amount  # Replace 'some_variable' with the actual variable you want to change

func get_nodes_from_type(type: String):
	# Get all nodes in the group
	var nodes = get_tree().get_nodes_in_group(type)
	return nodes
