extends Weapon

# Weapon Tipo Pistola; carga correctamente la información
var bullet9mm = preload("res://Nodes/Guns/Projectiles/bala_9_mm.tscn")
func _ready():
	change_bullet_type(bullet9mm)

