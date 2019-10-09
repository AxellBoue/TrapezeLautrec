extends Node2D

var Lautrec
var camera

var target

var targetIsMoyenne = true
onready var target2 = get_node("/root/Node2D/ilot depart/zoneCamera/targetZone")
onready var moyenne = get_node("moyenne")
var ratio = Vector2(0.5, 0.5)
#var targetZone ? assignée quand entre dans la zone, mais active et deviens target2 en fonction de la distance ?

var changeTarget = false
var nextTarget
var t

var changeZoom = false
var nextZoom
var tZoom 
var vitesseZoom


# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("Camera2D")
	Lautrec = get_node("/root/Node2D/Lautrec/targetCamera")
	target = moyenne
	global_position = target.global_position

func _physics_process(delta):
	
	if changeZoom :
		tZoom += delta/vitesseZoom
		camera.zoom = camera.zoom.linear_interpolate(nextZoom,tZoom)
		if  abs(camera.zoom.x-nextZoom.x) <= 0.002 :
			changeZoom = false

	if targetIsMoyenne :
			moyenne.global_position = Lautrec.global_position*ratio.x + target2.global_position*(1-ratio.x)	
	
	if changeTarget :
		t += delta/8
		global_position = global_position.linear_interpolate(nextTarget.global_position,t)
		if abs(global_position.distance_to(nextTarget.global_position)) <= 10 :
			#print("end change")
			target = nextTarget
			changeTarget = false
	else :
		global_position = target.global_position
		
func change_target_opti(var newTarget):
	if newTarget == moyenne :
		targetIsMoyenne = true
		moyenne.global_position = Lautrec.global_position*ratio.x + target2.global_position*(1-ratio.x)
	else :
		targetIsMoyenne = false
	target = newTarget

func change_target(var newTarget): #si c'est la target 2 qui change ? autre fonction ?
	if newTarget == moyenne :
		targetIsMoyenne = true
		moyenne.global_position = Lautrec.global_position*ratio.x + target2.global_position*(1-ratio.x)	
	else :
		targetIsMoyenne = false
	t = 0.0
	nextTarget = newTarget
	changeTarget = true

func change_zoom(var newZoom, newVitesseZoom = 10):
	tZoom = 0.0
	vitesseZoom = newVitesseZoom
	changeZoom = true
	nextZoom = Vector2(newZoom,newZoom)
	
	
	

	
	
	#version d'avant du mouvement de caméra : essaie de faire une transition smooth même avec changements de target pas voulus
func vrac(delta):
	if !changeTarget && abs(global_position.distance_to(target.global_position)) >= 0.5 :
		changeTarget = true
		#t = 0
	if changeTarget:
		t += delta
		global_position = global_position.linear_interpolate(target.global_position,t)
		if abs(global_position.distance_to(target.global_position)) <= 0.5 :
			changeTarget = false
			
	else :
		global_position = target.global_position
	