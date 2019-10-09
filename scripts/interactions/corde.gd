extends Node2D

onready var lautrec = get_node("/root/Node2D/Lautrec")
onready var rideaux = get_node("../../decor/rideaux")
onready var sm = get_node("/root/Node2D/gameManager/soundManager")
onready var sonRideaux = preload("res://sons/RideauV3.wav")
var ouvert = false
var interactionCompte = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.animation_set_next("bouge","idle")

func interaction():
	lautrec.anim.play("corde")
	lautrec.bloque(true)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("bouge")
	
func apres_anim():
	if ouvert :
		rideaux.play("ferme")
		sm.play_new_son(sm.get_node("ASP bruits"),sonRideaux)
	else :
		rideaux.play("ouvert")
		sm.play_new_son(sm.get_node("ASP bruits"),sonRideaux)
		if !interactionCompte:
			get_node("/root/Node2D/gameManager").add_inter_ilot_1()
			interactionCompte = true
	lautrec.anim.play("idle")
	lautrec.bloque(false)
	ouvert = !ouvert

