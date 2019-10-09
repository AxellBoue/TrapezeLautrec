extends Area2D

var firstTime = true
var timer

func _ready():
	var leotard = get_node("/root/Node2D/Lautrec")
# warning-ignore:return_value_discarded
	connect("body_entered",leotard,"_on_ilot_body_entered")
# warning-ignore:return_value_discarded
	connect("body_exited",leotard,"_on_ilot_body_exited")
# warning-ignore:return_value_discarded
	connect("body_entered",self,"_on_ilot_body_entered")
	
# warning-ignore:unused_argument
func _on_ilot_body_entered(body):
	if firstTime:
		firstTime = false
		var nm = get_node("/root/Node2D/gameManager/narrationManager")
		if name == "ilot cirque" :
			nm.lance_texte(nm.cirque)
			cree_timer()
		elif name == "ilot hp" :
			nm.lance_texte(nm.hp)
			cree_timer()
		disconnect("body_entered",self,"_on_ilot_body_entered")

func cree_timer():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",self,"_joue_son_later")
	timer.wait_time = 2
	timer.start()

func _joue_son_later():
	var sm = get_node("/root/Node2D/gameManager/soundManager")
	if name == "ilot cirque" :
		sm.play_new_son(sm.aspVoix, sm.voixCirque)
	elif name == "ilot hp" :
		sm.play_new_son(sm.aspVoix, sm.voixHp)
	timer.queue_free()