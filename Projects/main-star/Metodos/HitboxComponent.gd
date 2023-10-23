extends Area2D
class_name HitboxComponent

@export var damage :int = 1
@onready var collision = $CollisionShape2D

func _ready() -> void:
	# hithbox detecta HealthCompoentAreas
	area_entered.connect(hit) #conecta y creamos la funcion hit

func hit(area):
	if area is HealthComponent:
		area.take_damage(damage)

