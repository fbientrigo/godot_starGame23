# Build Mode
# contiene los elementos necesarios para hostear y hacer spawn de nuevas estrellas

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
	orbit_childs()
	

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
@export var GravitationConstant : float = 1

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
			
			var r : Vector2 = pos1 - pos2
			var r_scalar_3 : float = r.length_squared() * r.length() # r.length()**3
			
			# Aplica la ley de gravitación universal de Newton
			var applied_force : Vector2 = GravitationConstant * M * m * r / r_scalar_3
			force += applied_force
		# Actualiza la velocidad de la estrella según la fuerza aplicada
		estrella.velocity += force / (M+1) # mantiene realista pero quita el M=0 problem, fools proof

	# La variable 'force' ahora contiene la fuerza total entre todas las estrellas
	# Puedes usar esta información para actualizar las órbitas o realizar otras acciones
