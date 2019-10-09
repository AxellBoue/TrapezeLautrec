extends Area2D

func _ready():
	var leotard = get_node("/root/Node2D/Lautrec")
	connect("body_entered",leotard,"_on_ilot_body_entered")
	connect("body_exited",leotard,"_on_ilot_body_exited")