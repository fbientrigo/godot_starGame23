# Default Interactable Object
extends State


@export var animacion : AnimatedSprite2D
@export var sound : AudioStreamPlayer2D

@export var experience = 1

func collect():
	return experience

# Método llamado al entrar en este estado.
func Enter():
	if experience > 5:
		animacion.play("big_exp_anim")
	else:
		animacion.play("exp_anim")

# Método llamado al salir de este estado.
func Exit():
	pass

# Método llamado en cada fotograma para actualizar el estado.
# Parámetro "_delta" representa la cantidad de tiempo transcurrido desde el último fotograma.
func Update(_delta: float):
	pass

# Método llamado en cada fotograma de física para actualizar el estado relacionado con física.
# Parámetro "_delta" representa la cantidad de tiempo transcurrido desde el último fotograma.
func Physics_Update(_delta: float):
	pass



