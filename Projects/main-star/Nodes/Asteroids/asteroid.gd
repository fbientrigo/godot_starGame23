extends Area2D

var movement_vector := Vector2(1,-1)

enum AsteroidSize{LARGE, MEDIUM, SMALL}
@export var size := AsteroidSize.LARGE

@export var speed := 100

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

func _ready():
	rotation = randf_range(0,2*PI)
	
	match size:
		AsteroidSize.LARGE:
			speed = randf_range(50,100)
			# seleccionar escena random, o agrgar mas al enum
			sprite.texture = preload("res://Assets/Asteroids/small/asteroid_lvl3b.png")
			cshape.shape = preload("res://Nodes/Asteroids/collision_asteroid_lvl3b.tres")
		AsteroidSize.MEDIUM:
			speed = randf_range(100,150)
			sprite.texture = preload("res://Assets/Asteroids/small/asteroid_lvl2.png")
			cshape.shape = preload("res://Nodes/Asteroids/collision_asteroid_lvl2.tres")
		AsteroidSize.SMALL:
			speed = randf_range(100,200)
			sprite.texture = preload("res://Assets/Asteroids/small/asteroid_lvl0dying.png")
			cshape.shape = preload("res://Nodes/Asteroids/collision_asteroid_lvl0.tres")

