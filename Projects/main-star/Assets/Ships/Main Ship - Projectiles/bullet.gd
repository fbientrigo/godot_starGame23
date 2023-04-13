extends Node2D

#@export var animation_path : NodePath
#@onready var node_animation = get_node(animation_path)
@onready var node_animation = $Animation
var bullet_speed : float = 400

var velocity = Vector2(0, -bullet_speed)

#
func _ready():
	node_animation.play("auto_cannon")

func _physics_process(delta):
	# no hay friccion
	position += velocity * delta
	
	
func bullet_destruction():
	queue_free()


func _on_timer_timeout():
	print("el timer acabó, destruyendo bala:")
	bullet_destruction()


func _on_area_2d_body_entered(body):
	bullet_destruction()



