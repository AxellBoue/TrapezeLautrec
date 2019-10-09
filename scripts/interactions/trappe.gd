extends Area2D

onready var timer = get_node("Timer")
onready var lautrec = get_node("/root/Node2D/Lautrec")


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"_on_body_enter")
	timer.connect("timeout",self,"saut")

func _on_body_enter(body):
	timer.start()
	
func saut():
	lautrec.saut_special()
	timer.disconnect("timeout",self,"saut")
	timer.connect("timeout",self,"retour_de_saut")
	timer.wait_time = 3
	timer.start()
	
	
func retour_de_saut():
	lautrec.bloque(false)
	get_node("/root/Node2D/gameManager").add_inter_ilot_1()
	queue_free()
