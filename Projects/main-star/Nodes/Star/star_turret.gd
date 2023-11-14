# Componente de Torreta Estrella
extends Node2D

# Conexión con otros nodos

@onready var statemachine : StateMachine = $StateMachine
@onready var weaponstatemachine: WeaponStateMachine = $BasicWeaponStateMachine
@onready var light:PointLight2D = $PointLight2D
@onready var healthcomponent_collision:CollisionShape2D = $HealthComponent/CollisionShape2D

func _ready():
	set_star_type(tipo_estrella)
	

	
func set_star_type(tipo_estrella):
	# Sección de busquedo usando enum =============
	var nodo_hijo = statemachine.get_node(tipo_estrella)
	#print(nodo_hijo)
	if nodo_hijo:
		#print("nodo hijo encontrado")
		statemachine.initial_state = nodo_hijo
		statemachine.set_initial_state(nodo_hijo)
	else:
		print("Nodo hijo no encontrado.")
		
	var star_data = STAR_DATA.get(tipo_estrella, {})
	print("tipo estrella ", tipo_estrella)
	print("radio:",star_data["radio"])
#	var scale_factor = log(star_data["radio"])
	var scale_factor = sqrt(star_data["radio"])

	light.scale.x = int(30 + scale_factor * 20)
	light.scale.y = int(30 + scale_factor * 20)
	print("star_turred:")
	print("\tscale factor: ", scale_factor)
	print("\t light_scale\t", light.scale.x)
	
	if tipo_estrella == "TipoB":
		print(healthcomponent_collision)


# =====
# funciona para seguimiento de enemigos
var enemies = [] # array de enemies para guardarlos
var current_enemy


@export var can_shoot = true

# Controla el tipo de estrella mediante dropdown
@export_enum("TipoGas","TipoA","TipoB","TipoF","TipoG","TipoO","TipoK","TipoM","TipoWD","TipoRG","TipoSRG")
var tipo_estrella:String = "TipoGas"
# Upgrades de las estrellas



const STAR_DATA = {
	"TipoO": {
		"type": "O",
		"node_path": "TipoO",
		"masa": 50,
		"radio": 10,
		"temperatura": 40000,
		"abundancia": 0.00001,
		"tiempo_vida": 10
	},
	"TipoB": {
		"type": "B",
		"node_path": "TipoB",
		"masa": 10,
		"radio": 5,
		"temperatura": 20000,
		"abundancia": 0.1,
		"tiempo_vida": 100
	},
	"TipoA": {
		"type": "A",
		"node_path": "TipoA",
		"masa": 4,
		"radio": 1.7,
		"temperatura": 8500,
		"abundancia": 0.7,
		"tiempo_vida": 1000
	},
	"TipoF": {
		"type": "F",
		"node_path": "TipoF",
		"masa": 2,
		"radio": 1.3,
		"temperatura": 6500,
		"abundancia": 2,
		"tiempo_vida": 3000
	},
	"TipoG": {
		"type": "G",
		"node_path": "TipoG",
		"masa": 1,
		"radio": 1,
		"temperatura": 5700,
		"abundancia": 3.5,
		"tiempo_vida": 10000
	},
	"TipoK": {
		"type": "K",
		"node_path": "TipoK",
		"masa": 0.7,
		"radio": 0.8,
		"temperatura": 4500,
		"abundancia": 8,
		"tiempo_vida": 50000
	},
	"TipoM": {
		"type": "M",
		"node_path": "TipoM",
		"masa": 0.2,
		"radio": 0.3,
		"temperatura": 3200,
		"abundancia": 80,
		"tiempo_vida": 20000
	},
	"TipoWD": {
		"type": "WhiteDwarf",
		"node_path": "TipoWD",
		"masa": 1.4,
		"radio": 0.001,
		"temperatura": 70000,
		"abundancia": 5,
		"tiempo_vida": 99999
	},
	"TipoRG": {
		"type": "GiganteRojaK",
		"node_path": "TipoRG",
		"masa": 5,
		"radio": 50,
		"temperatura": 10000,
		"abundancia": 0.4,
		"tiempo_vida": 1000
	},
	"TipoSRG": {
		"type": "GiganteRoja",
		"node_path": "TipoSRG",
		"masa": 500,
		"radio": 500,
		"temperatura": 40000,
		"abundancia": 0.0001,
		"tiempo_vida": 20
	},
	"TipoGas": {
		"type": "Gas",
		"node_path": "TipoGas",
		"masa": 1,
		"radio": 0.5,
		"temperatura": 3000,
		"abundancia": 99999,
		"tiempo_vida": 99999
	},
	"TipoGas2": {
		"type": "Gas2",
		"node_path": "TipoGas2",
		"masa": 1,
		"radio": 0.5,
		"temperatura": 3000,
		"abundancia": 99999,
		"tiempo_vida": 99999
	}
}


@export var carga : float = 0
@export var masa : float = STAR_DATA[tipo_estrella]["masa"]
@export var tiempo_vida : float = STAR_DATA[tipo_estrella]["tiempo_vida"]
@export var rotacion :  float = 0

# Obtener datos de estrella por tipo
func get_star_data(star_type: String) -> Dictionary:
	return STAR_DATA.get(star_type, {})


@export var delta_vida : float = 200

func cambiar_estrella(_tipo_estrella):
	masa = STAR_DATA[_tipo_estrella]["masa"]
	tiempo_vida = STAR_DATA[_tipo_estrella]["tiempo_vida"]
	var new_state = statemachine.get_node(_tipo_estrella)
	statemachine.set_initial_state(new_state)

func _physics_process(delta):
	#weaponstatemachine.current_state.fire(0, Vector2(0,0))
	if enemies != []:
		current_enemy = enemies[0]
		if can_shoot:
			weaponstatemachine.current_state.fire(global_rotation, current_enemy.global_position, PI)
	tiempo_vida -= delta_vida * delta 
#	print(tiempo_vida)
	# Comportamiento de G para el sol
	
	# ============ Evolucion Estelar ========================================
	if tipo_estrella == "TipoG":
		# chequear si llega a la mitad de su masa
		if masa < 0.7 * get_star_data(tipo_estrella)["masa"]:
			light.color = Color(0.85, 0.395, 0.374)
		elif masa < 0.5 * get_star_data(tipo_estrella)["masa"]:
			if carga < 2:
				tipo_estrella = "TipoRG" # gigante roja
			else:
				tipo_estrella = "TipoSRG"
				
			print("starturret estrella tipo G ha llegado al 50% de suministros, coviertiendo en RedGiant")
			cambiar_estrella(tipo_estrella)
		elif tiempo_vida < 0:
			light.color = Color(0.85, 0.395, 0.374)
			if carga < 2:
				tipo_estrella = "TipoRG" # gigante roja
			else:
				tipo_estrella = "TipoSRG"
			cambiar_estrella(tipo_estrella)
		
	if tipo_estrella == "TipoRG":
		if tiempo_vida < 0:
			tipo_estrella = "TipoWD"
			light.color = Color(1, 1, 1)
			print("starturret: convirtiendo RG en WhiteDwarf")
			cambiar_estrella(tipo_estrella)
			
	if tipo_estrella == "TipoB":
	# Check if the star has lost a significant amount of its mass
#		if masa < 0.7 * get_star_data(tipo_estrella)["masa"]:
#			# The star becomes a blue supergiant
#			tipo_estrella = "TipoBSG"  # Blue Supergiant
#			print("StarTurret: B-type star has lost significant mass, evolving into Blue Supergiant")
#			cambiar_estrella(tipo_estrella)
		if tiempo_vida < 0:
			# The star has exhausted its nuclear fuel and collapses into a neutron star or black hole
			if masa <= 3:  # Assuming stars with mass <= 3 times the mass of the sun become neutron stars
				tipo_estrella = "TipoNS"  # Neutron Star
				print("StarTurret: B-type star has exhausted nuclear fuel, evolving into Neutron Star")
			else:  # Stars with mass > 3 times the mass of the sun become black holes
				tipo_estrella = "TipoBH"  # Black Hole
				print("StarTurret: B-type star has exhausted nuclear fuel, evolving into Black Hole")
			cambiar_estrella(tipo_estrella)

		



func _on_sensor_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies.append(area)


func _on_sensor_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies.erase(area)

var health : int  = 10
func _on_health_component_hurt(damage):
	health = health - damage
	if masa > 0:
		masa -= 0.1 * damage/2
	# Aqui se pueden agregar if's dependiendo del tipo de estrella
	if health < 0:
		queue_free()

func _on_health_component_on_dead():
	queue_free()

func _on_area_2d_area_entered(area):
	pass

# Conectados mediante communicationBus
func upgrade_carga(ammount):
	carga += ammount

func upgrade_masa(ammount):
	masa += ammount
	health += 1

func upgrade_rotacion(ammount):
	rotacion += rotacion
	

# 1012 comentado pues no parece servir de nada
#func evolve_tower(new_tower):
#	# Carga la nueva escena
#	var evolved_tower = load("res://Characters/Star/"+new_tower+".tscn").instance()
#	# Get the parent of the current tower (the container that holds the tower nodes)
#	var parent = get_parent()
#
#	# Replace the current tower node with the evolved tower node
#	parent.replace_child(self, evolved_tower)
#
#	# Optionally, you can set the evolved tower's position and name to match the current tower
#	evolved_tower.position = position
#	evolved_tower.name = name
#	var star_data = STAR_DATA.get(new_tower, {})
##	print("radio:",star_data["radio"])
##	var scale_factor = log(star_data["radio"])
#	var scale_factor = star_data["radio"]
##	print("star_turred:")
##	print("\t light_scale\t", light.scale.x)
#	light.scale.x = scale_factor *100
#	light.scale.y = scale_factor *100
#	queue_free()





