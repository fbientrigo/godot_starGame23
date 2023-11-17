extends State
class_name Weapon



# mientras vamos a tenerlo ya agregado para pruebas
# var bullet := preload("res://Nodes/Guns/Projectiles/bala_9_mm.tscn")

# cada state se proecupa de su propio cooldown

var last_shot = 0 # cuando lastshoot es menor no dispara
var projectiles = []
var bullet : PackedScene
#var source_body = get_parent().position



func low_level_fire(rotation, direction, phase = 0.0,type='direction',hardpoint=self):

	var projectile = bullet.instantiate()
	projectile.position = hardpoint.global_position
	var bullet_speed = projectile.bullet_speed
	if type == 'rotation':
		projectile.rotation = rotation + phase
	elif type == 'direction':
		projectile.rotation = hardpoint.global_position.angle_to_point(direction) - PI/2 + phase
	
	# noviembre
	#var porjectile_rotation = projectile.rotation
	var velocity = Vector2(0,-bullet_speed).rotated(projectile.rotation)
	print("from:",self,"lowlevelfire : ,velocity: ", velocity, " rotation:", projectile.rotation)
	
	get_node("/root").add_child(projectile)
	
	projectiles.append({
		"projectile": projectile,
		"velocity": velocity,
		"ticks": 0,
		"damage": projectile.bullet_damage
	})

func _process(_delta):
	last_shot += 1

func change_bullet_type(new:PackedScene):
	bullet = new

#func _physics_process(delta):
#	last_shot += 1
#	for p_obj in projectiles:
#		var p = p_obj["projectile"]

	# el nodo se preocupa de desaparecer por si solo		
#		if p_obj["ticks"] >= 40:
#			p.queue_free()
#			projectiles.erase(p_obj)
#			pass
		
		
		# las colisiones son controladas por un collider
#		if (collision):
#			var collider = collision.collider
#			if (collider.get_class() == "HealthComponent"):
#				collider.take_damage(p_obj["bullet_damage"])

