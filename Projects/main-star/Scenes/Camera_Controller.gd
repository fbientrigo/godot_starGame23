extends Node2D


@export var player_path: NodePath
@onready var player :Node2D = get_node(player_path)
var mira_path : NodePath = ^"%Crosshair_onShip"
var mira : Node2D 

func _ready():
	mira = get_node(mira_path)
#	print("camera controller, crosshair:")
#	print(mira_path)
#	print(mira)
#	print("-----ccc") 

# vieja funcion de centrar la camara que usa el player

var interpolate_val = 10
func _process(delta):

	if mira and mira.is_inside_tree():
		var target : Vector2 = player.global_position
		var targetlook : Vector2 = mira.global_position
		var mid_x = (target.x + targetlook.x) / 2
		var mid_y = (target.y + targetlook.y) / 2
		global_position = global_position.lerp(Vector2(mid_x,mid_y), interpolate_val * delta) 
	else:
		pass # no se porque hay momentos en que mira deja de existir


# funcion que hacia uso de el el deadzone
# pero con el nuevo sistema de fuerza, quedo buggy y mareaba


#const Dead_Zone = 100
#func _input(event: InputEvent) -> void:
#	# se ajusta a la pos del jugar
#	self.position = player.global_position
#
#	if event is InputEventMouseMotion: # si es que ve al mouse
#		# _target = posMouse - la mitad de la pantalla
#		var _target =  get_viewport().size * 0.5 - event.position
#		if _target.length() < Dead_Zone: # 
#			self.position += Vector2(0,0) # tiembla mucho al volver al player
#		else: # deadzone muy grande no se mueve
#			self.position += _target.normalized() * (_target.length() - Dead_Zone) * 0.5




