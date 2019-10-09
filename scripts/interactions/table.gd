extends Node2D

var lautrec
var sm #sound manager
var cameraBox

var assis = false
onready var sonChaise = preload("res://sons/chaise v2.wav")
var debut = true

# voix debut
onready var voixdebut = preload("res://sons/Voix Off Intro.wav")
var debutVoix = true

# Called when the node enters the scene tree for the first time.
func _ready():
	lautrec = get_node("/root/Node2D/Lautrec")
	sm = get_node("/root/Node2D/gameManager/soundManager")
	cameraBox = get_node("/root/Node2D/gameManager/cameraBox")
	interaction()

func interaction():
	get_node("lautrecAssis").visible = !assis
	get_node("table sans lautrec").visible = assis
	lautrec.set_visible(assis)
	lautrec.bloque(!assis)
	if assis:
		cameraBox.change_zoom(1.2,8)
	else :
		cameraBox.change_zoom(0.7,8)
		get_node("objInteractif").feedback.visible = false
	if !debut:
		sm.play_new_son(get_node("AudioStreamPlayer2D"), sonChaise)
	else : 
		debut = false
	if debutVoix && assis:
		sm.play_new_son(sm.aspVoix, voixdebut) 
		debutVoix = false
		var nm = get_node("/root/Node2D/gameManager/narrationManager")
		nm.lance_texte(nm.intro)
	assis = !assis

func anim_texte_1(var num):
	pass