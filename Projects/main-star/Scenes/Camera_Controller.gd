extends Node2D


@export var player_path: NodePath
@onready var player = get_node(player_path)



const Dead_Zone = 300
func _input(event: InputEvent) -> void:
	# se ajusta a la pos del jugar
	self.position = player.global_position
	if event is InputEventMouseMotion: # si es que ve al mouse
		# _target = posMouse - la mitad de la pantalla
		var _target = event.position - get_viewport().size * 0.5
		if _target.length() < Dead_Zone: # 
			self.position += Vector2(0,0) # tiembla mucho al volver al player
		else: # deadzone muy grande no se mueve
			self.position += _target.normalized() * (_target.length() - Dead_Zone) * 0.5


# vieja funcion de centrar la camara que usa el player
#
#var interpolate_val = 1
#func _physics_process(delta):
#	var target : Vector2 = player.global_position
#	var mid_x = (target.x + get_global_mouse_position().x) / 2
#	var mid_y = (target.y + get_global_mouse_position().y) / 2
#
#	global_position = global_position.lerp(Vector2(mid_x,mid_y), interpolate_val * delta) 
#



