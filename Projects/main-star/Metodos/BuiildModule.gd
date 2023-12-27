# Build Mode
# contiene los elementos necesarios para hostear y hacer spawn de nuevas estrellas

extends Node2D

var map_node # representa referencias a botones con informacion

var build_mode = false
var build_valid = false
var build_location
var build_type
var estrellas : Array = []

@onready var star_scene : PackedScene = preload("res://Nodes/Star/star_turret.tscn")

@export var min_initial_speed = 35
@export var max_initial_speed = 65

# initial count
var ammount_stars : int = 0

func _ready():
	# encontrar la estrella de mayor masa primero
	# dar una variable interna que indique que es la estrella de amyor masa
	estrellas = self.get_children()
	ammount_stars = len(estrellas)

	set_top_masa(estrellas) # pone un marcado en la estrella con más masa
	initialize_star_orbits(estrellas)
	

func _process(_delta):
	# tecla E se conecta a initiate_build_mode, default construye nebulosa
	# 1,2,3,4... controla por debug el tipo de torre
	estrellas = self.get_children()
	orbit_childs()
	
	if len(estrellas) != ammount_stars:
		set_top_masa(estrellas)
		ammount_stars = len(estrellas)
		
	
	if Input.is_action_just_pressed("spawnstar"):
		ammount_stars += 1
		add_star('Gas')
		#estrellas = self.get_children()
		#set_top_masa(estrellas)
		#initialize_star_orbits(estrellas)

func initialize_star_orbits(_estrellas):
	estrellas = self.get_children()
	for estrella in estrellas:
		if estrella.top_masa == false:
			#print("less masa encontrada")
			estrella.position = Vector2(5*randf_range(-max_initial_speed,max_initial_speed), 5*randf_range(-max_initial_speed,max_initial_speed))
			estrella.velocity = Vector2(2*(randf()-0.5)*randf_range(min_initial_speed,max_initial_speed),2*(randf()-0.5)* randf_range(min_initial_speed,max_initial_speed))
		else:
			estrella.position = Vector2(0,0) # define el orgien para la top masa

func set_top_masa(_estrellas):
	estrellas = self.get_children()
	var top_masa : float = 0
	var record_masa_idx : int = 0
	if estrellas == []:
		return 0
	
	for idx in range(len(estrellas)):
		var estrella : StarTurret = estrellas[idx]
		if estrella.masa > top_masa: # >= provoca que existan repetidas top masa
			top_masa = estrella.masa
			record_masa_idx = idx
		elif estrella.masa < top_masa:
			estrella.top_masa = false
	estrellas[record_masa_idx].top_masa = true



func _unhandled_input(_event):
	pass

# DEVLOG: 231213
	# el modo build ha sido quitado
	# de querer construir realizarlo mediante cartas
	# por implementar
	# agregar poner estrellas


#func initiate_build_mode(tower_type):
	#build_type = tower_type
	#build_mode = true
	#get_node("UI")

func update_tower_preview():
	pass

func cancel_build_mode():
	pass

func verify_and_build():
	pass

# Constante gravitatoria (ajusta según tus necesidades)
@export var GravitationConstant : float = 12
# Función logística para limitar applied_force entre 0 y 4
func logistic_limit(x: float) -> float:
	var k: float = 0.1 # Ajusta este valor para controlar la pendiente de la función
	return GravitationConstant / (1.0 + exp(-k * x))
# Calcula las órbitas de las estrellas

func orbit_childs():
	#estrellas = self.get_children()
	#var estrellas : Array = self.get_children() # Obtén todas las estrellas como nodos hijos
	var force : Vector2 = Vector2.ZERO # Inicializa la fuerza total como cero
	
	if estrellas == []:
		return 0
	
		
	for index in range(len(estrellas)):
		if estrellas[index] != null:
			var estrella : StarTurret =  estrellas[index]
			var M : float = estrella.masa
			var pos1 : Vector2 = estrella.global_position
			
			for index2 in range(index):
				var estrella2 : StarTurret = estrellas[index2]
				var m : float = estrella2.masa
				var pos2 : Vector2 = estrella2.global_position
				
				var r : Vector2 = pos2 - pos1
				r = r.normalized()
				var r_scalar_2 : float = r.length_squared() +  0.01# r.length()**3
				var mm = logistic_limit(M * m) # para evitar errores y overflows
				# Aplica la ley de gravitación universal de Newton
				var applied_force : Vector2 = (mm  / r_scalar_2  )*r
				
				
				force += applied_force
				
			# Actualiza la velocidad de la estrella según la fuerza aplicada
			#print("applied force: ", force)
			estrella.velocity += force / (M+1) # mantiene realista pero quita el M=0 problem, fools proof
			

	# La variable 'force' ahora contiene la fuerza total entre todas las estrellas
	# Puedes usar esta información para actualizar las órbitas o realizar otras acciones

func add_star(type):
	var estrella = star_scene.instantiate()
	
	#add_child(estrella)
	call_deferred("add_child", estrella)
	
	estrellas = self.get_children()
	set_top_masa(estrellas)
	
	if estrella.top_masa == false:
	#print("less masa encontrada")
		estrella.position = Vector2(5*randf_range(-max_initial_speed,max_initial_speed), 5*randf_range(-max_initial_speed,max_initial_speed))
		estrella.velocity = Vector2(2*(randf()-0.5)*randf_range(min_initial_speed,max_initial_speed),2*(randf()-0.5)* randf_range(min_initial_speed,max_initial_speed))
	else:
		estrella.position = Vector2(0,0) # define el orgien para la top masa

	

