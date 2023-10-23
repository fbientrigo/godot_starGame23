extends Weapon


# Weapon Tipo Pistola; carga correctamente la información

var bulletheavy= preload("res://Nodes/Guns/Projectiles/bala_heavy.tscn")

func _ready():
	change_bullet_type(bulletheavy)
	

