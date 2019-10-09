extends Area2D

var perso
var zonePop
export (bool) var horizontal = true

# Called when the node enters the scene tree for the first time.
func _ready():
	perso = get_node("/root/Node2D/Lautrec")
	zonePop = get_node("zonePop")
# warning-ignore:return_value_discarded
	connect("body_entered",self,"teleporte")


func teleporte(body):
	if body == perso:
		if horizontal:
			if !perso.surTrapeze:
				perso.global_position = Vector2(perso.global_position.x,zonePop.global_position.y)
			else :
				perso.trapezeActif.global_position = Vector2(perso.trapezeActif.global_position.x,zonePop.global_position.y)
			
		else :
			if !perso.surTrapeze:
				perso.global_position = Vector2(zonePop.global_position.x,perso.global_position.y)
			else:
				perso.trapezeActif.global_position = Vector2(zonePop.global_position.x,perso.trapezeActif.global_position.y)
