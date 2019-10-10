extends Area2D

onready var timer = get_node("Timer")
onready var lautrec = get_node("/root/Node2D/Lautrec")
onready var afficheQueen = get_node("/root/Node2D/ilot depart/decor/afficheQueen")
onready var sm = get_node("/root/Node2D/gameManager/soundManager")
var sonShow = preload("res://sons/ShowMustGoOn.wav")
onready var rideaux = get_node("/root/Node2D/ilot depart/decor/rideaux")
onready var trampo = get_node("trampoline")

var i = 0

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_body_enter")
	timer.connect("timeout",self,"saut")

# warning-ignore:unused_argument
func _on_body_enter(body):
	timer.start()
	#trampo.play("bas")
	
func saut():
	lautrec.saut_special()
	trampo.play("saut")
	timer.disconnect("timeout",self,"saut")
	timer.connect("timeout",self,"retour_de_saut")
	timer.wait_time = 1.5
	timer.start()
	sm.play_new_son(sm.get_node("ASP bruits"),sonShow)
	rideaux.play("ouvert")
	afficheQueen.get_node("AnimationPlayer").play("feuDArtifice")
	
func retour_de_saut():
	if i ==0:
		i += 1
		afficheQueen.play("default")
		timer.wait_time = 2
		timer.start()
	
	else :
		lautrec.bloque(false)
		get_node("/root/Node2D/gameManager").add_inter_ilot_1()
		queue_free()
