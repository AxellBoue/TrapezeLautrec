extends Node2D

var lautrec
var sm #sound manager
var cameraBox

var assis = false
onready var sonChaise = preload("res://sons/chaise v2.wav")
var debut = true
onready var lautrecAssis = get_node("lautrecAssis")

# voix debut
onready var voixdebut = preload("res://sons/Voix Off Intro.wav")
var debutVoix = true

# boit
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	lautrec = get_node("/root/Node2D/Lautrec")
	sm = get_node("/root/Node2D/gameManager/soundManager")
	cameraBox = get_node("/root/Node2D/gameManager/cameraBox")
	timer.connect("timeout",self,"boit")
	interaction()

func interaction():
	lautrecAssis.visible = !assis
	get_node("table sans lautrec").visible = assis
	lautrec.set_visible(assis)
	lautrec.bloque(!assis)
	if assis:
		cameraBox.change_zoom(1.2,8)
		timer.stop()
	else :
		cameraBox.change_zoom(0.7,8)
		get_node("objInteractif").feedback.visible = false
		lautrecAssis.play("assis")
		timer.start()
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

func boit():
	lautrecAssis.play("boit")
	
func fin_anim():
	if lautrecAssis.animation == "boit":
		lautrecAssis.play("assis")