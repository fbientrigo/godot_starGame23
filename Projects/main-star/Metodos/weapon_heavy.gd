extends Weapon


# Weapon Tipo Pistola; carga correctamente la información

var bulletheavy= preload("res://Nodes/Guns/Projectiles/bala_heavy.tscn")
# fase de la escopeta, mayor angulo mayor deflexión
var phase_recoil = PI/6

@export var cooldown = 10.0


func _ready():
	change_bullet_type(bulletheavy)
	
func fire(rotation,direction, phase=0.0,type='direction',hardpoint=self):
	if last_shot < cooldown: 
		return
	else:
		last_shot = 0
	
	low_level_fire(rotation,direction,phase,'direction')
	low_level_fire(rotation,direction,phase+phase_recoil,'direction')
	low_level_fire(rotation,direction,phase-phase_recoil,'direction')

