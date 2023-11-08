# Boilerplate for player-specific states
# Gives autocompletion for the player
class_name PlayerState
extends State

var ship: Node2D


func _ready() -> void:
	await owner.ready
	ship = owner
