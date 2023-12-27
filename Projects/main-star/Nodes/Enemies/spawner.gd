extends Marker2D

@export var mob_scene : Array[PackedScene]=[]# aqui van los enemies
@export var spawn_interval_min:float = 5
@export var spawn_interval_max:float = 8
@export var spawn_radius:float = 2

var ENEMY_CAP = 100
var multiplier : float = 1
@export var probabilidadSpawn : float = 0.7

@onready var evolution_timer : Timer = $evolution_time
@onready var spawn_timer : Timer = $spawn_time
#func _ready():
	#


func _on_spawn_time_timeout():
	print("spawning timeout")
	# contar a los enemigos y ver si spawnear mas

	if randf() > (1-probabilidadSpawn): # el 70% del tiempo hace spawns
		var enemigos = get_tree().get_nodes_in_group("Enemy")
		var contador = enemigos.size()
		print("Hay", contador, " enemigos en la escena")
		if contador < ENEMY_CAP:
			spawn_something(multiplier)
			spawn_timer.wait_time = randf_range(spawn_interval_min,spawn_interval_min)
			print("spawn timer: ", spawn_timer.wait_time)
			print("spawn timer stopped: ", spawn_timer.is_stopped())
		else:
			print("ENEMY CAP alcanzado")
	


var evolved_level = 0
func _on_evolution_time_timeout():
	print("evolution timer ", evolution_timer.wait_time)
	multiplier = multiplier*1.01 + 0.3
	evolved_level += 0.5
	probabilidadSpawn = probabilidadSpawn + 0.3 * tanh(evolved_level)
	#print("aplicando evolución")




func spawn_something(multiplier):
	#print("spawning enemy")
	#var basic_enemy_tsc = preload("res://Nodes/Enemies/Enemy.tscn")
	var basic_enemy_tsc = mob_scene.pick_random()
	var new_enemy = basic_enemy_tsc.instantiate()
	# spawn en un circulo al rededor del origen
	var theta = 2 * PI *  randf()
	var spawn_position = Vector2(spawn_radius * cos(theta), spawn_radius * sin(theta))
	new_enemy.global_position = spawn_position
	new_enemy.velocity = - spawn_position
	new_enemy.evolve_stats(multiplier)
	add_child(new_enemy)
	print("enemy spawned: ", new_enemy)
	
	
	# crea un timer para saber cuando hacer spawn
	#var spawn_time = randf_range(spawn_interval_min, spawn_interval_max)
	#get_tree().create_timer(spawn_time).timeout.connect(spawn_something)
	
	




