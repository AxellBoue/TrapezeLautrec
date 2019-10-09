extends Area2D

var firstTime = true

func _ready():
	var leotard = get_node("/root/Node2D/Lautrec")
	connect("body_entered",leotard,"_on_ilot_body_entered")
	connect("body_exited",leotard,"_on_ilot_body_exited")
	connect("body_entered",self,"_on_ilot_body_entered")
	
func _on_ilot_body_entered(body):
	if firstTime:
		firstTime = false
		var nm = get_node("/root/Node2D/gameManager/narrationManager")
		if name == "ilot cirque" :
			nm.lance_texte(nm.cirque)
		elif name == "ilot hp" :
			nm.lance_texte(nm.hp)
		disconnect("body_entered",self,"_on_ilot_body_entered")
	