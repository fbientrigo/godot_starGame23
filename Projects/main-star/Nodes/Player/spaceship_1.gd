extends RigidBody2D


## Nivel de exp:
#var experience_level = 1
#var experience = 0 # global exp, flush per level
#var collected_experience = 0 # constant flush

# ==== 1107 tarjetas de levl up 1:22am

#@export var velocidad_nave : float = 300
@export var animation_damage_sprites: NodePath

#EXP GUI
#@onready var expBar = get_node("%ExperienceBar")
#@onready var lbl_level = get_node("%lbl_level")
#@export var expBar : TextureProgressBar
#@export var lbl_level : Label
# Seccion de fuerzas =======================================
# se puede encontrar el sistema de toruqe que conecta con el movimiento del mouse
# se desea entregar un realismo en sonido y movimiento
@export var torque_strength: float
@export var propulsor_strength: float
@export var crosshair : Node2D

# combinar con el health component
@onready var _animated_sprite = get_node(animation_damage_sprites)
@onready var sound_thursters : AudioStreamPlayer2D = $Sounds/Thursters
@onready var sound_dash : AudioStreamPlayer2D = $Sounds/Dash2

@onready var timer_dash : Timer = $Timers/Dash
@onready var cooldown_dash : Timer = $Timers/CanDash
@export var dash_power : int = 3
#@onready var parent : Node2D = get_parent()
#var levelPanel : Node2D
#var upgradeOptions : Node2D
#var sndLevelUp : Node2D 

func _ready():
	pass
	
	#print("Hello world")
#	set_expbar(experience, calculate_experienceCap())


@export var can_dash : bool = false
var dashing : bool = false # esta en estado de dash

func unlock_dash():
	can_dash = true

func dash_ctrl():
	if can_dash and Input.is_action_just_pressed("dash"):
		dashing = true
		can_dash = false
		sound_dash.play()
		timer_dash.start()

func _on_dash_timeout():
	dashing = false
	cooldown_dash.start()
func _on_can_dash_timeout():
	can_dash = true




# codigo sin testear, me falta implementar funcionalidad
func _on_EngineState_Changed(_oldstate, _newstate):
	# controla el cambio de señales para dar aviso al padre
	# print(oldstate)
	# print(newstate)
	pass
	



func get_input_actions():
	if Input.is_action_pressed("click"):
		pass
		# llamar funcion de disparo


func _integrate_forces(_state):
	# sigue la posicion del mouse, y calcula el torque
	var direction_position : Vector2 = crosshair.global_position
	var difference : Vector2  = direction_position - global_position
	var angle_to_look : float = difference.angle_to(transform.y)
	
	dash_ctrl()

	# deja de temblar la nave
	if abs(abs(angle_to_look) - PI) > 0.15:
		# Calculate the torque to apply
		var torque = angle_to_look * torque_strength
		# Apply the torque to the spaceship
		apply_torque(torque)
	else:
		pass # se pierde el control de la nave, animación
	
	if Input.is_action_pressed("w"):
#		if sound_thursters.playing != true:
#			sound_thursters.play()
		match dashing:
			true: #dash activo
				apply_force( - transform.y  * Input.get_action_strength("w") * propulsor_strength * (dash_power+1))
				$Particles/Dash.emitting = true
			false:
				apply_force( - transform.y  * Input.get_action_strength("w") * propulsor_strength )
				$Particles/Dash.emitting = false
# Grabbing de Experiencia ================

func _on_grabber_area_entered(area):
	if area.is_in_group("Loot"):
		area.target = self
		

signal got_exp(exp_recb)

# envia una señal al nodo jugador con la info de exp
func _on_picker_area_entered(area):
	if area.is_in_group("Loot"):
		var exp_recb = area.collect()
		#print("recibida exp:", exp_recb)
		emit_signal("got_exp", exp_recb)


#
#func _physics_process(delta):
#	# escucha input extra
#	if Input.is_action_just_pressed("levelupgod"):
#		print("god send 20xp")
#		give20xp_asgod()
#
#
## signal shoot_pass_from_equipment(bullet, direction, location)
#
## el equipamiento llama a la bala a utilizar
## 1020 comentado para el nuevo sistema
##func _on_equipment_shoot(bullet_, direction_, location_):
##	emit_signal("shoot_pass_from_equipment", bullet_, direction_, location_)
#
#
## Grabbing de Experiencia ================
#
#func _on_grabber_area_entered(area):
#	if area.is_in_group("Loot"):
#		area.target = self
#
#
#
#func _on_picker_area_entered(area):
#	if area.is_in_group("Loot"):
#		var exp_recb = area.collect()
#		#print("recibida exp:", exp_recb)
#		calculate_experience(exp_recb)
#
#
#func give20xp_asgod():
#	# Funcion que sirve como debug, se programa a una tecla secreata
#	# para asi probar subir e nivel
#	calculate_experience(20)
#
##Recibir la experiencie
#func calculate_experience(exp_recb):
#	# limits de exp por nivel
#	var exp_required = calculate_experienceCap()
#	#print("actual exp:", experience)
#	collected_experience += exp_recb
#	if experience + collected_experience >= exp_required: #levelup
#		collected_experience -= exp_required - experience
#		experience_level += 1
#		lbl_level.text = str("Nivel: ", experience_level)
#		experience = 0
#		exp_required = calculate_experienceCap()
#
#		levelUp() # 1107, se agrega la ufnción leevlup
#
#		calculate_experience(0) #? usar experiencia restante
#	else:
#		experience += collected_experience
#		collected_experience = 0
#
#	# configura la barra
#	set_expbar(experience, exp_required)
#
#func calculate_experienceCap():
#	var exp_cap = 2
#	if experience_level < 10:
#		exp_cap = 5 * experience_level
#	elif experience_level < 20:
#		exp_cap = 8 * experience_level
#	elif experience_level < 40:
#		exp_cap = 95 * (experience_level-19)
#	else:
#		exp_cap = 255 * (experience_level-39)
#	return exp_cap
#
#func set_expbar(set_value = 1, set_max_value=100):
#	# Configuracion de la barra
#	expBar.value = set_value
#	expBar.max_value = set_max_value
#
#
## ==== 1107 tarjetas de levl up 1:22am
#func levelUp():
#	# sndLevelUp.play()
#	print("spaceship_1.gd")
#	print("func levelUP")
#
#	var tween = levelPanel.create_tween()
#	tween.tween_property(levelPanel, "position", Vector2(170,160), 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
#	tween.play()
#	levelPanel.visible = true
#
## ========================================
#




