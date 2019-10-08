extends Node2D

var chapeauDroite
var chapeauGauche

# Called when the node enters the scene tree for the first time.
func _ready():
	chapeauDroite = get_node("/root/Node2D/ilot depart/decor/chapeaux/hommedroitestatic")
	chapeauGauche = get_node("/root/Node2D/ilot depart/decor/chapeaux/hommegauchestatic")


func interaction():
	chapeauDroite.play("ouvre")
	chapeauGauche.play("ouvre")
	get_node("/root/Node2D/ilot depart/decor/chapeaux/objInteractif3").queue_free()
