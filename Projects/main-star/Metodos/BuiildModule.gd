extends Node2D

var map_node # representa referencias a botones con informacion

var build_mode = false
var build_valid = false
var build_location
var build_type

func _ready():
	pass

func _process(delta):
	# tecla E se conecta a initiate_build_mode, default construye nebulosa
	# 1,2,3,4... controla por debug el tipo de torre
	
	pass

func _unhandled_input(event):
	pass

func initiate_build_mode(tower_type):
	build_type = tower_type
	build_mode = true
	get_node("UI")

func update_tower_preview():
	pass

func cancel_build_mode():
	pass

func verify_and_build():
	pass
