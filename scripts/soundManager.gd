extends Node2D

var aspZoneCabaret
#onready var sonCabaret = preload("res://sons/Ambiace bar musique.wav")
onready var sonVynile = preload("res://sons/Vinyle1.wav")
var aspLautrec
onready var sonPas = preload("res://sons/bruits pas_mixdown.wav")
var aspVoix


# Called when the node enters the scene tree for the first time.
func _ready():
	aspZoneCabaret = get_node("ASP cabaret")
	#aspZoneCabaret.stream = sonCabaret
	#aspZoneCabaret.play(0)
	aspLautrec = get_node("/root/Node2D/Lautrec/AudioStreamPlayer")
	aspVoix = get_node("ASP voix")


func play_new_son(var streamPlayer, var son, var streamPlayerToStop = null):
	streamPlayer.stream = son
	streamPlayer.play(0)
	if streamPlayerToStop :
		streamPlayerToStop.stop()

func play_pas():
	if !aspLautrec.playing :
		play_new_son(aspLautrec,sonPas)

func stop_pas():
	aspLautrec.stop()

