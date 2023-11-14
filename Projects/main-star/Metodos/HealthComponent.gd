# Hey, I'm Hurting, dice el hitbox al componente de salud
# Este script maneja la salud y las interacciones de daño de la entidad.
#
# ultima actualizacion: 10/01/23ft
# commit m: actualización documentación
# tiempo: 6:34pm
# endtime: 7pm

# Definimos el tipo de objeto, es una clase heredada de area2D
extends Area2D
class_name HealthComponent

# Señal emitida cuando la entidad alcanza una salud de 0.
signal onDead

# Señal emitida cuando la entidad recibe daño.
# Parámetros:
# - damage: La cantidad de daño recibido.
signal hurt(damage)

# La salud máxima de la entidad.
@export var max_health : int = 10

# Referencias a nodos internos.
# to do
# [] tamaño de colision puede cambiar con una señal del statemachine
@onready var collision = $CollisionShape2D 
@onready var disableTimer = $DisableTimer

# ---- Sección de HurtBox ------
# Tipos de HurtBox disponibles:
# 0 - "Cooldown": La entidad se enfriará durante un tiempo después de recibir daño.
# 1 - "HitOnce": La entidad solo puede ser golpeada una vez antes de su destrucción.
@export_enum("Cooldown","HitOnce") var HurtBoxType = 0

# ----- Tipo de Muerte -----------
# Tipos de muerte disponibles:
# - "Enemy": La entidad es un enemigo y se destruirá.
# - "Star": La entidad es una estrella y no realizará ninguna acción adicional.
# - "Mineral": La entidad es un mineral y no realizará ninguna acción adicional.
# - "Player": La entidad es el jugador y se mostrará un mensaje de jugador muerto.
@export_enum("Enemy","Star","Mineral","Player") var DeadType = 0

# Salud actual de la entidad.
var current_health : int = 1

func _ready() -> void:
	current_health = max_health

# Aumenta la salud actual de la entidad.
func take_heal(value:int):
	set_health(value)

# Reduce la salud actual de la entidad.
func take_damage(damage:int):
#	print(self.get_parent())
#	print("HealthCompo", damage)
	var value = abs(damage)
	set_health(-value)
	emit_signal("hurt",damage) # para sprites u otros
	# Desconecta temporalmente las colisiones según el tipo de HurtBox.
	match HurtBoxType:
		0: # Cooldown
			collision.call_deferred("set","disabled",true)
			disableTimer.start()
		1:
			pass

func _on_disable_timer_timeout():
	# Vuelve a activar las colisiones desactivadas temporalmente.
	collision.call_deferred("set","disabled",false)

# Establece la salud de la entidad.
func set_health(value:int):
	current_health += value
	current_health = clamp(current_health, 0, max_health)
	#print("Vida actual:", current_health)
	if current_health <= 0:
		dead()

# Maneja las acciones a realizar cuando la entidad alcanza una salud de 0.
func dead():
	emit_signal("onDead")
	match DeadType:
		0: # Tipo Enemigo
			get_parent().call_deferred("queue_free")
		1: # Tipo Estrella
			pass
		2: # Tipo Mineral
			pass
		3: # Tipo Jugador
			print("El jugador está muerto")
