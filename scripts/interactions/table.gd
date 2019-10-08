extends Node2D

var lautrec
var sm #sound manager
var cameraBox

var assis = false
onready var sonChaise = preload("res://sons/chaise.wav")
var debut = true

# voix debut
onready var voixdebut = preload("res://sons/Voix Off Intro.wav")
var debutVoix = true
var animTexte1
onready var texte1 = get_node("/root/Node2D/CanvasLayer/Control/texte 1")
onready var texte2 = get_node("/root/Node2D/CanvasLayer/Control/texte 2")
onready var texte3 = get_node("/root/Node2D/CanvasLayer/Control/texte 3")


# Called when the node enters the scene tree for the first time.
func _ready():
	lautrec = get_node("/root/Node2D/Lautrec")
	sm = get_node("/root/Node2D/gameManager/soundManager")
	cameraBox = get_node("/root/Node2D/gameManager/cameraBox")
	texte1.visible=false
	texte2.visible=false
	texte3.visible=false
	animTexte1 = get_node("AnimationPlayer")
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
		animTexte1.play("animTexte1")
	assis = !assis

func anim_texte_1(var num):
	if num == 0:
		texte1.visible = true
	elif num == 1:
		texte1.visible=false
		texte2.visible = true
	elif num == 2:
		texte2.visible=false
		texte3.visible=true
	elif num == 3:
		texte3.visible=false