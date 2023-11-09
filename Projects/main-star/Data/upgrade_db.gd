extends Node

# carpeta de las tarjetas
const CARD_PATH = "res://Assets/LevelCards/"

const df = {
	"masa": {
		"icon": CARD_PATH+"mass_star.png",
		"player": false,
		"star": true, 
		"display_name": "+ masa",
		"ammount": 1,
		"prerequisite":[]
	},
	"rotacion": {
		"icon": CARD_PATH+"rotation_star.png",
		"player": false,
		"star": true, 
		"display_name": "+ rotacion",
		"ammount": 1,
		"prerequisite":[]
	},
	"carga": {
		"icon": CARD_PATH+"charge_star.png",
		"player": false,
		"star": true, 
		"display_name": "+ carga",
		"ammount": 1,
		"prerequisite":[]
	},
	"dash": {
		"icon": CARD_PATH+"dash_ship.png",
		"player": true,
		"star": true, 
		"display_name": "dash",
		"ammount": 1,
		"prerequisite":[]
	},
	
	
}
