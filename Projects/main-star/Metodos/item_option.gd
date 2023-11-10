extends ColorRect

# Carta de selección
# es una carta seleccionable con la que el jugador puede
# hacer upgrades


# item se refiere a la carta que es
# de acuerdo a la base de datos existen: 1108
# masa, rotacion, carga, dash
var item = null

# buscara al jugador
@onready var textura = get_node("TextureRect")
@onready var nombre = get_node("Nombre")
@onready var player = get_tree().get_first_node_in_group("player_root")

# con que se comunica para mejorar
@export var is_star = false
@export var is_player = true
# funcionamiento logico
var mouse_over = false

signal selected_upgrade(upgrade)

func _ready():
	if item == null:
		item = "masa" # por default
	
	# selecciona de la base de datos en autoload global la informacion
	#		"icon","display_name","ammount"
	print(item)
	var dfitem = UpgradeDb.df[item]
	nombre.text = UpgradeDb.df[item]["display_name"]
	textura.texture = load(UpgradeDb.df[item]["icon"])
	
	
	if is_player:
		connect("selected_upgrade", Callable(player, "upgrade_character"))
	elif is_star:
		print("en item_option.gd")
		print("aun no esta implementada la estrella, usar un algoritmo de busqueda")
		pass

func _input(event):
	# para seleccionar
	if Input.is_joy_known(Input.get_connected_joypads()[0]):
		if event.is_action("joyaccept"):
			if mouse_over:
				emit_signal("selected_upgrade", item)
	else:
		if event.is_action("click"):
			if mouse_over:
				emit_signal("selected_upgrade", item)

func _process(delta):
	if mouse_over:
		textura.modulate = "#ffffff"
	else:
		textura.modulate = "#9a9a9a"

# por ahora se seleccionara con el mouse
# en el futuro puedo usar el crosshair u otra estrategia
func _on_mouse_entered():
	mouse_over = true
	

func _on_mouse_exited():
	mouse_over = false
	
