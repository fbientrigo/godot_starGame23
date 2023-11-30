# Build Mode
# contiene los elementos necesarios para hostear y hacer spawn de nuevas estrellas

extends Node2D

var map_node # representa referencias a botones con informacion

var build_mode = false
var build_valid = false
var build_location
var build_type

@export var min_initial_speed = 20
@export var max_initial_speed = 50
func _ready():
	# encontrar la estrella de mayor masa primero
	# dar una variable interna que indique que es la estrella de amyor masa
	var estrellas : Array = self.get_children()

	set_top_masa(estrellas) # pone un marcado en la estrella con más masa
	initialize_star_orbits(estrellas)
	

func _process(delta):
	# tecla E se conecta a initiate_build_mode, default construye nebulosa
	# 1,2,3,4... controla por debug el tipo de torre
	orbit_childs()

func initialize_star_orbits(estrellas):
	for estrella in estrellas:
		if estrella.top_masa == false:
			print("less masa encontrada")
			estrella.velocity = Vector2(randf_range(min_initial_speed,max_initial_speed), randf_range(min_initial_speed,max_initial_speed))
		else:
			estrella.position = Vector2(0,0) # define el orgien para la top masa

func set_top_masa(estrellas):
	var top_masa : float = 0
	var record_masa_idx : int = 0
	for idx in range(len(estrellas)):
		var estrella : StarTurret = estrellas[idx]
		if estrella.masa >= top_masa:
			top_masa = estrella.masa
			record_masa_idx = idx
		elif estrella.masa < top_masa:
			estrella.top_masa = false
	estrellas[record_masa_idx].top_masa = true



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

# Constante gravitatoria (ajusta según tus necesidades)
@export var GravitationConstant : float = 10
# Función logística para limitar applied_force entre 0 y 4
func logistic_limit(x: float) -> float:
	var k: float = 0.1 # Ajusta este valor para controlar la pendiente de la función
	return GravitationConstant / (1.0 + exp(-k * x))
# Calcula las órbitas de las estrellas

func orbit_childs():
	var estrellas : Array = self.get_children() # Obtén todas las estrellas como nodos hijos
	var force : Vector2 = Vector2.ZERO # Inicializa la fuerza total como cero
	
	for index in range(len(estrellas)):
		var estrella : StarTurret =  estrellas[index]
		var M : int = estrella.masa
		var pos1 : Vector2 = estrella.global_position
		
		for index2 in range(index):
			var estrella2 : StarTurret = estrellas[index2]
			var m : int = estrella2.masa
			var pos2 : Vector2 = estrella2.global_position
			
			var r : Vector2 = pos2 - pos1
			r = r.normalized()
			var r_scalar_2 : float = r.length_squared() +  1# r.length()**3
			var mm = logistic_limit(M * m)
			# Aplica la ley de gravitación universal de Newton
			var applied_force : Vector2 = mm * r / r_scalar_2
			
			
			force += applied_force
			
		# Actualiza la velocidad de la estrella según la fuerza aplicada
		print("applied force: ", force)
		estrella.velocity += force / (M+1) # mantiene realista pero quita el M=0 problem, fools proof
		
		
		
	# La variable 'force' ahora contiene la fuerza total entre todas las estrellas
	# Puedes usar esta información para actualizar las órbitas o realizar otras acciones
