extends Weapon

# Weapon Tipo Pistola; carga correctamente la información
var bullet9mm = preload("res://Nodes/Guns/Projectiles/bala_9_mm.tscn")

@export var cooldown = 4.0
@export var max_recoil = PI/24

func _ready():
	change_bullet_type(bullet9mm)

	
func fire(rotation,direction, phase=0.0,_type='direction',_hardpoint=self):
	if last_shot < cooldown: 
		return
	else:
		last_shot = 0
	
	low_level_fire(rotation,direction, phase +  max_recoil*(randf()-0.5),'direction')
