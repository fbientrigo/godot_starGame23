extends Node2D
class_name Projectile

#@export var animation_path : NodePath
#@onready var node_animation = get_node(animation_path)
@onready var node_animation = $Animation

var explosion : PackedScene
var explosion_animation_name : String


@export var bullet_speed : float = 300
@export var bullet_damage : int = 60

func _ready():
	pass

func _physics_process(delta):
	# no hay friccion
	position += Vector2(0,-bullet_speed).rotated(rotation) * delta

	
func bullet_destruction():
	queue_free()

func _on_timer_timeout():
	#print("el timer acabó, destruyendo bala:")
	bullet_destruction()

# Funciona con el hitbox component modular
func _on_hitbox_component_area_entered(area):
	if area is HealthComponent:
		area.take_damage(bullet_damage)
		
		var explosion_instance = explosion.instantiate()
		explosion_instance.position = get_global_position()
		# hay distintas explosiones que se pueden acceder
		# en este caso es un impacto basico
		explosion_instance.play(explosion_animation_name)
		get_tree().get_root().add_child(explosion_instance)
		bullet_destruction()


# Legacy code
# anteriormente hacia lo del hitboxcomponent
func _on_area_2d_body_entered(_body):
	pass
