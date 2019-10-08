extends Node2D

onready var lautrec = get_node("/root/Node2D/Lautrec")
onready var rideaux = get_node("../../decor/rideaux")
var ouvert = false

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
	else :
		rideaux.play("ouvert")
	lautrec.anim.play("idle")
	lautrec.bloque(false)
	ouvert = !ouvert

