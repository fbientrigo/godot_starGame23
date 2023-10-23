extends Projectile

# Bullet tipo 9 mm
# extiende a la clase proyectil


func _ready():
	
	explosion = preload("res://Nodes/Guns/Projectiles/bala_explosion.tscn")
	explosion_animation_name = "circle"

	if bullet_damage >= 5:
		node_animation.play("Bigbullet")
	node_animation.play("bullet")


