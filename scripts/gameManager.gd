extends Node2D

onready var camera = get_node("cameraBox")
onready var timer = get_node("Timer")
var timerConnection

var interactionIlot1 = 0
var trappe = preload("res://objets/trappe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("test"):
		cree_trappe()

func add_inter_ilot_1 ():
	interactionIlot1 += 1;
	if interactionIlot1 == 3:
		cree_trappe()
	if interactionIlot1 >= 4 :
		set_timer_connection("dezoom")
		timer.wait_time = 1
		timer.start()

func dezoom():
	camera.change_zoom(2.2)
	set_timer_connection("rezoom")
	timer.wait_time = 6
	timer.start()

func rezoom():
	camera.change_zoom(1.2,2)

func cree_trappe():
	var newTrape = trappe.instance()
	get_node("/root/Node2D/ilot depart").add_child(newTrape)
	
func set_timer_connection(var newC):
	if timerConnection:
		timer.disconnect("timeout",self,timerConnection)
	timerConnection = newC
	timer.connect("timeout",self,timerConnection)
		
		
