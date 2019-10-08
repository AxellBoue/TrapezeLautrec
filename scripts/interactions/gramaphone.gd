extends Node2D

var lautrec
var sm #sound manager
var cameraBox

onready var gramo = get_node("/root/Node2D/ilot depart/objets/gramaphone/gramophone1")
var isPlaying = true

# Called when the node enters the scene tree for the first time.
func _ready():
	lautrec = get_node("/root/Node2D/Lautrec")
	sm = get_node("/root/Node2D/gameManager/soundManager")
	cameraBox = get_node("/root/Node2D/gameManager/cameraBox")
	gramo.play("joue")

func interaction():
	if isPlaying :
		isPlaying = false
		gramo.play("eteint")
		#sm.play_new_son(sm.aspZoneCabaret,sm.sonVynile)
	else :
		isPlaying = true
		gramo.play("joue")
		#sm.play_new_son(sm.aspZoneCabaret,sm.sonCabaret)
	