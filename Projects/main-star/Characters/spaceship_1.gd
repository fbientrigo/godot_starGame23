extends CharacterBody2D

func _ready():
	print("Hello world")

func _on_EngineState_Changed(oldstate, newstate):
	# controla el cambio de señales para dar aviso al padre
	print(oldstate)
	print(newstate)
