# Componente de Torreta Estrella
extends Node2D

# Conexión con otros nodos
@export var statemachine : StateMachine
# Controla el tipo de estrella mediante dropdown
@export_enum("TipoGas","TipoA","TipoB","TipoF","TipoG","TipoO","TipoK","TipoM","TipoWD","TipoRG","TipoSRG") var tipo_estrella:String = "TipoGas"


func _ready():
	# Sección de busquedo usando enum =============
	var nodo_hijo = statemachine.get_node(tipo_estrella)
	print(nodo_hijo)
	if nodo_hijo:
		print("nodo hijo encontrado")
		statemachine.initial_state = nodo_hijo
		
		statemachine.set_initial_state(nodo_hijo)
	else:
		print("Nodo hijo no encontrado.")


# =====
# funciona para seguimiento de enemigos
var enemies = [] # array de enemies para guardarlos
var current_enemy


# {Tipo,Masa,Radio en masas solares, Temperatura Kelvin, AbundanciaPercent, Tiempo Vida Millon de años}
const DATA = {
	O=["O",50,10,40000,0.00001,10],
	B=["B",10,5,20000,0.1,100],
	A=["A",2,1.7,8500,0.7,1000],
	F=["F",1.5,1.3,6500,2,3000],
	G=["G",1,1,5700,3.5,10000],
	K=["K",0.7,0.8,4500,8,50000],
	M=["M",0.2,0.3,3200,80,20000],
	WD=["WhiteDwarf",1.4,0.001,70000,5,99999],
	# Variacion Gigante Roja
	GiganteRojaK = ["GiganteRojaK",5,50,10000,0.4,1000],
	#super red giant_, vive poco:
	GiganteRoja = ["GiganteRoja",500,500,40000,0.0001,10],
	Gas = ["Gas",1,0.5,3000,99999], # Proto
	Gas2 = ["Gas2",1,0.5,3000,99999], # Nebula
}

# @export_enum("A","B","F","G","Gas","Gas2","GiganteRoja","GiganteRojaK","K","M","O","WhiteDwarf") var tipo_estrella:String = "Gas"


func _physics_process(delta):
	if enemies != []:
		current_enemy = enemies[0]


func evolve_tower(new_tower):
	# Carga la nueva escena
	var evolved_tower = load("res://Characters/Star/"+new_tower+".tscn").instance()
	# Get the parent of the current tower (the container that holds the tower nodes)
	var parent = get_parent()

	# Replace the current tower node with the evolved tower node
	parent.replace_child(self, evolved_tower)

	# Optionally, you can set the evolved tower's position and name to match the current tower
	evolved_tower.position = position
	evolved_tower.name = name
	queue_free()


# Para disparar a los enemigos debe de hacerse un call por un medio




func _on_sensor_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies.append(area)


func _on_sensor_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies.erase(area)

var health = 3

func _on_area_2d_area_entered(area):
	health = health - 1
	if health < 0:
		queue_free()
