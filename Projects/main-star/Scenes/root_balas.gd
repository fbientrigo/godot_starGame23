extends Node2D
var Bullet = load("res://Assets/Ships/Main Ship - Projectiles/bullet.tscn")

func _on_Player_shoot(Bullet_, direction_, location_):
	var b = Bullet_.instantiate()
	add_child(b)
	b.rotation = direction_
	b.position = location_
	b.velocity = b.velocity.rotated(direction_)


func _on_spaceship_1_shoot_pass_from_equipment(bullet_, direction_, location_):
	print("llego al root de balas")
	_on_Player_shoot(bullet_, direction_, location_)
	
