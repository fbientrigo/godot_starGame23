extends State
class_name Weapon



# mientras vamos a tenerlo ya agregado para pruebas
# var bullet := preload("res://Nodes/Guns/Projectiles/bala_9_mm.tscn")

@export var cooldown = 25

var last_shot = cooldown + 5 # cuando lastshoot es menor no dispara
var projectiles = []
var bullet : PackedScene
#var source_body = get_parent().position



func fire(rotation, direction, hardpoint=self):
	
	if last_shot < cooldown: return
	else: last_shot = 0

	var projectile = bullet.instantiate()

	var bullet_speed = projectile.bullet_speed
	projectile.rotation = rotation
	projectile.position = hardpoint.global_position
	#projectile.add_collision_exception_with(s)
	get_node("/root").add_child(projectile)
	
	
	
	
	var velocity = Vector2(bullet_speed,0).rotated(rotation)
	
	projectiles.append({
		"projectile": projectile,
		"velocity": velocity,
		"ticks": 0,
		"damage": projectile.bullet_damage
	})

func _process(delta):
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

