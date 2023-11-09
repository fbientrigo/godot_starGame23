# PlayerCode
# guarda la logica sobre como tratar con 
# - niveles
# - animaciones
# - cantidad de vida
extends Node2D

# Nivel de exp:
var experience_level = 1
var experience = 0 # global exp, flush per level
var collected_experience = 0 # constant flush

# ==== 1107 tarjetas de levl up 1:22am

@export var velocidad_nave : float = 300
@export var animation_damage_sprites: NodePath

#EXP GUI
#@onready var expBar = get_node("%ExperienceBar")
#@onready var lbl_level = get_node("%lbl_level")
@export var expBar : TextureProgressBar
@export var lbl_level : Label
@export var spaceship : RigidBody2D
# Seccion de fuerzas =======================================
# se puede encontrar el sistema de toruqe que conecta con el movimiento del mouse
# se desea entregar un realismo en sonido y movimiento

@export var crosshair : Node2D

# combinar con el health component
@onready var _animated_sprite = get_node(animation_damage_sprites)

# upgrades
@export var levelPanel : Panel
@export  var upgradeOptions : HBoxContainer
@export var sndLevelUp : AudioStreamPlayer
@onready var itemOptions = preload("res://Metodos/item_option.tscn")

var collected_upgrades = [] # se guardan las mejoras del player
var upgrade_options = [] # upgrades en oferta
# para mejoras futuras:
var armor = 0
var speed = 0
var spell_cooldown = 0 
var spell_size = 0
var additional_attacks = 0


func _ready():
#	levelPanel= get_node("%LevelUpPanel")
#	upgradeOptions= get_node("%UpgradeOptions")
#	sndLevelUp = get_node("%snd_levelup")
	set_expbar(experience, calculate_experienceCap())




func _physics_process(delta):
	# escucha input extra
	# esta input es para debugging
	if Input.is_action_just_pressed("levelupgod"):
		print("god send 20xp")
		give20xp_asgod()


# signal shoot_pass_from_equipment(bullet, direction, location)

# el equipamiento llama a la bala a utilizar
# 1020 comentado para el nuevo sistema
#func _on_equipment_shoot(bullet_, direction_, location_):
#	emit_signal("shoot_pass_from_equipment", bullet_, direction_, location_)


# Grabbing de Experiencia ================
# esta función esta ocurriendo para spaceship supongo
#func _on_grabber_area_entered(area):
#	if area.is_in_group("Loot"):
#		area.target = self
#
#func _on_picker_area_entered(area):
#	if area.is_in_group("Loot"):
#		var exp_recb = area.collect()
#		#print("recibida exp:", exp_recb)
#		calculate_experience(exp_recb)

# la spaceship recibe experiencia y se comunica con este nodo jugador
# para explicarle cuanta exp llegó
func _on_spaceship_1_got_exp(exp_recb):
	calculate_experience(exp_recb)

func give20xp_asgod():
	# Funcion que sirve como debug, se programa a una tecla secreata
	# para asi probar subir e nivel
	calculate_experience(10)

#Recibir la experiencie
func calculate_experience(exp_recb):
	# limits de exp por nivel
	var exp_required = calculate_experienceCap()
	#print("actual exp:", experience)
	collected_experience += exp_recb
	if experience + collected_experience >= exp_required: #levelup
		collected_experience -= exp_required - experience
		experience_level += 1
		lbl_level.text = str("Nivel: ", experience_level)
		experience = 0
		exp_required = calculate_experienceCap()
		
		levelUp() # 1107, se agrega la ufnción leevlup
		
		calculate_experience(0) #? usar experiencia restante
	else:
		experience += collected_experience
		collected_experience = 0
	
	# configura la barra
	set_expbar(experience, exp_required)

func calculate_experienceCap():
	var exp_cap = 2
	if experience_level < 10:
		exp_cap = 5 * experience_level
	elif experience_level < 20:
		exp_cap = 8 * experience_level
	elif experience_level < 40:
		exp_cap = 95 * (experience_level-19)
	else:
		exp_cap = 255 * (experience_level-39)
	return exp_cap

func set_expbar(set_value = 1, set_max_value=100):
	# Configuracion de la barra
	expBar.value = set_value
	expBar.max_value = set_max_value


# ==== 1107 tarjetas de levl up 1:22am
func levelUp():
	sndLevelUp.play()
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel, "position", Vector2(170,160), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax: # spawneara opciones
#		print("player spawning options")
#		print("\t",get_parent())
#		print("\t",options)
#		print("\t ----")
		var options_choice = itemOptions.instantiate() # agrega objeto carta
		options_choice.item = get_random_item() # elige el tipo de carta
		upgradeOptions.add_child(options_choice)
		options += 1
	get_tree().paused = true # pausa el juego por detras
	# El panel debe de estar en modo WhenPaused y no Inherit
	# o se pausara tambien

# 1108 10pm comencé
func upgrade_character(upgrade):
	var options_children = upgradeOptions.get_children() 
	for op in options_children:
		op.queue_free() # remueve las opciones tras elegir una
	upgrade_options.clear() # limpiar ofertas
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.position = Vector2(170,800) #vuelve a bajar la pantalla
	get_tree().paused = false
	calculate_experience(0) # para despabilar


func get_random_item():
	# selecciona solo 1 mejora aleatoria dela base de datos
	# dado que se cumplan condiciones de no repetición
	var dblist = []
	for upgrade_name in UpgradeDb.df:
		var upgrade = UpgradeDb.df[upgrade_name]
		if upgrade["player"]: # si es tipo jugador
			if upgrade_name in collected_upgrades:
				print("player.gd\n upgrade repetida, no sumandola")
				pass
			elif upgrade in upgrade_options: # si ya la eligimos en mostrar
				pass
			elif upgrade["prerequisite"].size()>0:
				for requisito in upgrade["prerequisite"]: # check si tenemos requisitos
					# tipo strings
					if not requisito in collected_upgrades:
						pass
					else:
						dblist.append(upgrade_name)
			else:
				dblist.append(upgrade_name)
		elif upgrade["star"]: # las estrellas se pueden agregar siempre
			dblist.append(upgrade_name)
			
	if dblist.size() > 0:
		var random_card = dblist.pick_random() # str
		var random_upgrade = UpgradeDb.df[random_card]
		if random_upgrade["player"]: # si es tipo player es persistente
			upgrade_options.append(random_card)
		return random_card
	else: # si nada cumplio las condiciones, agregaremos cartas basura
		return null

	
# ========================================

