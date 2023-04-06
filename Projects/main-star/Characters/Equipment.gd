extends Node2D

signal engine_state_changed(old_value, new_value)



# Define the engine states
enum EngineStates {
	IDLE,
	BASE_THRUST,
	SUPER_THRUST
}

@export var spaceship_1_path: NodePath
@export var engine_anim_path: NodePath
# @export var bullet_path: NodePath

var bullet = load("res://Assets/Ships/Main Ship - Projectiles/bullet.tscn")

@onready var spaceship_1 = get_node(spaceship_1_path)
@onready var engine_anim = get_node(engine_anim_path)
# @onready var bullet = get_node(bullet_path)



var current_engine_state = EngineStates.IDLE

func _ready():
	pass


	
signal shoot(bullet, direction, location)
	
func change_engine_state():
	if Input.is_action_just_pressed("i"):
		var old_state = current_engine_state
		current_engine_state = EngineStates.BASE_THRUST
		engine_state_changed.emit()



# =======
@onready var cooldown_weapon_timer = $cooldown_weapon
@export var cooldown_weapon_time : float

func _process(_delta):
	print(cooldown_weapon_timer.time_left)

	if Input.is_action_pressed("w"):
		engine_anim.play("base_engine_idle")
	else:
		engine_anim.stop()


	if Input.is_action_pressed("click") and cooldown_weapon_timer.is_stopped():
		cooldown_weapon_timer.start(cooldown_weapon_time)
		emit_signal("shoot", bullet,  global_rotation, global_position)
		
	



func _on_cooldown_weapon_timeout():
	pass # Replace with function body.
