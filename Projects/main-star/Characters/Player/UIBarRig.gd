# Ensures that the health and cargo UI bars don't rotate when the player does.
extends Node2D


func _ready() -> void:
	set_as_top_level(true)
