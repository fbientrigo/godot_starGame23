# Primary node that takes care of sending setup instructions to some of the
# game's sub-systems; passing along the location of the map viewport for
# mappable objects, informing pirates of obstacles in the world, and 
# giving the player access to the game camera.
extends Node

var _spawned_positions := []
var _world_objects := []

@onready var map: MapView = $MapView
@onready var camera := $GameWorld/Camera3D
@onready var hud := $UI/HUD


func _ready() -> void:
	Events.connect("station_spawned",Callable(self,"_on_Spawner_station_spawned"))
	Events.connect("asteroid_spawned",Callable(self,"_on_Spawner_asteroid_spawned"))
	Events.connect("pirate_spawned",Callable(self,"_on_Spawner_pirate_spawned"))

	camera.setup_camera_map(map)

	ObjectRegistry.register_distortion_parent($DistortMaskView/SubViewport)
	camera.setup_distortion_camera()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (not ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED
		get_viewport().set_input_as_handled()


func _on_Spawner_pirate_spawned(pirate: PirateShip) -> void:
	pirate.setup_world_objects(_world_objects)
	Events.emit_signal("node_spawned", pirate)


func _on_Spawner_station_spawned(station: DockingPoint, player: PlayerShip) -> void:
	_world_objects.append(weakref(station))

	hud.initialize(player)
	player.grab_camera(camera)
	Events.emit_signal("node_spawned", station)
	Events.emit_signal("node_spawned", player)


func _on_Spawner_asteroid_spawned(asteroid: DockingPoint) -> void:
	_world_objects.append(weakref(asteroid))
	Events.emit_signal("node_spawned", asteroid)
