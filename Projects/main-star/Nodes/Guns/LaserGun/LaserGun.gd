# A gun that casts a LaserBeam2D. Deals damage per second on the laser's
# collider.

class_name LaserGun
extends Node2D

@export var damage_per_second := 200.0

@onready var laser_beam := $LaserBeam2D
@onready var shooter := owner

@onready var audio: LoopingAudioStreamPlayer2D = $LaserGunSounds

var is_firing := false : set = set_is_firing
var collision_mask := 0 : set = set_collision_mask


func _ready() -> void:
	set_physics_process(false)
	laser_beam.add_exception(owner)


func _physics_process(delta: float) -> void:
	if laser_beam.is_colliding():
		Events.emit_signal("damaged", laser_beam.get_collider(), damage_per_second * delta, shooter)


func set_is_firing(firing: bool) -> void:
	is_firing = firing

	set_physics_process(is_firing)
	laser_beam.is_casting = is_firing
	if is_firing:
		audio.start()
	else:
		audio.end()


func set_collision_mask(new_mask: int) -> void:
	collision_mask = new_mask
	laser_beam.collision_mask = collision_mask
