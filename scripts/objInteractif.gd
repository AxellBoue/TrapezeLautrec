extends Area2D

export (String) var interaction
var feedback
var lautrec
var parent


# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_node("../")
	feedback = get_node("feedback")
	feedback.visible = false
	lautrec = get_node("/root/Node2D/Lautrec")
	var zoneInteraction = get_node("zoneInteraction")
	#zone affiche loogo
# warning-ignore:return_value_discarded
	connect("body_entered",self,"on_zone_logo_body_enter")
# warning-ignore:return_value_discarded
	connect("body_exited",self, "on_zone_logo_body_exited")
	#zone feedback
	zoneInteraction.connect("body_entered",self,"on_zone_interaction_body_enter")
	zoneInteraction.connect("body_exited",self,"on_zone_interaction_body_exited")
	

func on_zone_interaction_body_enter(var body):
	if body == lautrec :
		feedback.play("fixe")
		lautrec.on_objet_body_enter(self)

func on_zone_interaction_body_exited(var body):
	if body == lautrec :
		feedback.play("clignote")
		lautrec.on_objet_body_exit(self)
	
func on_zone_logo_body_enter(var body):
	if body == lautrec :
		feedback.play("clignote")
		feedback.visible = true

func on_zone_logo_body_exited(var body):
	if body == lautrec :
		feedback.stop()
		feedback.visible = false
		
		
func do_interaction():
	parent.interaction()

		