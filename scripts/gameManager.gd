extends Node2D

onready var camera = get_node("cameraBox")
onready var timer = get_node("Timer")
var timerConnection

var interactionIlot1 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("test"):
		pass

func add_inter_ilot_1 ():
	interactionIlot1 += 1;
	if interactionIlot1 >= 3 :
		set_timer_connection("dezoom")
		timer.wait_time = 1
		timer.start()

func dezoom():
	camera.change_zoom(2.2)
	set_timer_connection("rezoom")
	timer.wait_time = 6
	timer.start()

func rezoom():
	camera.change_zoom(1.2,5)
	
func set_timer_connection(var newC):
	if timerConnection:
		timer.disconnect("timeout",self,timerConnection)
	timerConnection = newC
	timer.connect("timeout",self,timerConnection)
		
		
