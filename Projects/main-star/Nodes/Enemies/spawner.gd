extends Marker2D

@export var mob_scene : Array[PackedScene]=[]# aqui van los enemies
@export var spawn_interval_min:float = 2
@export var spawn_interval_max:float = 5
@export var spawn_radius:float = 20

func _ready():
	spawn_something()

func spawn_something():
	#var basic_enemy_tsc = preload("res://Nodes/Enemies/Enemy.tscn")
	var basic_enemy_tsc = mob_scene.pick_random()
	var new_enemy = basic_enemy_tsc.instantiate()
	# spawn en un circulo al rededor del origen
	var theta = 2 * PI *  randf()
	var spawn_position = Vector2(spawn_radius * cos(theta), spawn_radius * sin(theta))
	new_enemy.global_position = global_position + spawn_position
	add_child(new_enemy)
	
	var spawn_time = randf_range(spawn_interval_min, spawn_interval_max)
	get_tree().create_timer(spawn_time).timeout.connect(spawn_something)
	
	
