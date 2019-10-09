extends KinematicBody2D

var surIlot = true
var enSaut = false 
var enChuteSansSaut = false
var surTrapeze = false

var isLautrec = true

var anim
var nextAnim

var targetCamera

# mouvement sur ilot a plat
export (int) var  vitesse = 200
var velocity
var direction = "droite"
var flip = 1

# saut et chute
export var gravite = 9
export var forceSaut = 400
var forceSautSpecial
var mvtV = 0
export (int) var maxGravite = 1500

#capte saut sur ilot
var capteSol

# création du trapèze 
onready var trapezeObj = preload("res://objets/trapeze.tscn")
export var decalageTrapeze = Vector2(200,-200) 
var trapezeActif
var poignee

#transformations
export var offsetPieds =  Vector2(0,-61)
export var offsetTrapeze = Vector2(-20,50)
var sauteLater = false

#interaction
var obj = null
var isBloque = false

var sm

# Called when the node enters the scene tree for the first time.
func _ready():
	capteSol = get_node("capteSol")
	targetCamera = get_node("targetCamera")
	sm = get_node("/root/Node2D/gameManager/soundManager")
	anim = $AnimatedSprite
	anim.play("LautrecIdle")
	ajuste_camera_pieds()
	print(get_collision_layer_bit(1))
	

func _input(event):
	if event.is_action_pressed("saut") && !isBloque:
		if surTrapeze :
			lache_trapeze()
		elif !enSaut && !enChuteSansSaut:
			if isLautrec :
				deviensLeotardAvecSaut()
			else :
				saute()
		else:
			cree_trapeze()
			
	if event.is_action_pressed("interaction"):
		if obj && isLautrec:
			obj.do_interaction()
			
	if event.is_action_pressed("test"):
		pass
		#saut_special()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("haut"):
		velocity.y -= 1
	if Input.is_action_pressed("bas"):
		velocity.y += 1
	if Input.is_action_pressed("droite"):
		velocity.x += 1
		if !surTrapeze :
			flip = 1
			direction = "droite"
			anim.set_flip_h(false)
		#if surTrapeze:
			#anim.offset = Vector2(offsetTrapeze.x*flip,offsetTrapeze.y)
		
	if Input.is_action_pressed("gauche"):
		velocity.x -= 1
		if !surTrapeze :
			flip = -1
			direction = "gauche"
			anim.set_flip_h(true)
		#if surTrapeze:
			#anim.offset = Vector2(offsetTrapeze.x*flip,offsetTrapeze.y)
		
	velocity = velocity.normalized() * vitesse
	
	
func _physics_process(delta):
	if !isBloque:
		get_input()
	else :
		velocity = Vector2(0,0)
		
	if surTrapeze :
		global_position = poignee.global_position
			
	elif surIlot && !enSaut:
		velocity = move_and_slide(velocity)
		if velocity.x == 0 && velocity.y == 0 && anim.animation != "transformation":
			anim.set_flip_h(false)
			flip = 1
			direction = "droite"
			anim.play("LautrecIdle")
			sm.stop_pas()
		else :
			if anim.animation != "transformation":
				anim.play("lautrecMarche")
				sm.play_pas()
					
	else : #if enSaut || !surIlot
		mvtV += gravite
		if mvtV >= maxGravite :
			mvtV = maxGravite
		velocity =Vector2(velocity.x, velocity.y + mvtV) #pas prendre en compte haut/bas ?
		velocity = move_and_slide(velocity)
		capteSol.position = Vector2(0,clamp(capteSol.position.y - mvtV*delta,0,200))


## mouvements et création de trapeze

func saute( var force = forceSaut):
	enSaut = true
	mvtV -= force
	sm.stop_pas()
	
func fin_de_saut():
	enSaut = false
	if surIlot && !surTrapeze:
		mvtV = 0
		deviensLautrec()
	else :
		enChuteSansSaut = true
	capteSol.position = Vector2(0,9)

func _on_ilot_body_exited(body):
	if body == self:
		surIlot = false
		if !enSaut && !surTrapeze && anim.animation != "transformation":
			enChuteSansSaut = true
			set_collision_layer_bit(1,false)
			anim.play("lautrecTombe")
			sm.stop_pas()

func _on_ilot_body_entered(body):
	if body == self:
		surIlot = true
		if !enSaut && !surTrapeze:
			mvtV=0
			deviensLautrec()
		enChuteSansSaut = false

func cree_trapeze():
	trapezeActif = trapezeObj.instance()
	get_tree().get_root().add_child(trapezeActif)
	trapezeActif.position = Vector2(position.x + decalageTrapeze.x*flip, position.y + decalageTrapeze.y)
	# modif frame de depart selon le coté
	if direction == "gauche":
		trapezeActif.get_node("AnimationPlayer").seek(1.5,true)
	ajuste_camera_trapeze()
	if isLautrec :
		deviensLeotardTrapeze()
	else :
		anim.play("LeoBalance")
	poignee = trapezeActif.get_node("poigneeTrapeze")
	surTrapeze = true
	enSaut = false
	enChuteSansSaut = false
	mvtV=0

func lache_trapeze():
	surTrapeze = false
	trapezeActif.trapeze_destroy()
	var forceSautTrapeze = (abs(trapezeActif.rotation) * forceSaut)*1.2
	trapezeActif = null
	anim.play("LeoSaute")
	ajuste_camera_pieds()
	mvtV=0
	saute(forceSautTrapeze) # hauteur en fonction d'angle du trapeze ?

# warning-ignore:unused_argument
func _on_capteSol_body_entered(body):
	fin_de_saut()

func ajuste_camera_trapeze():
	anim.offset = Vector2(offsetTrapeze.x*flip,offsetTrapeze.y)
	targetCamera.position = offsetTrapeze

func ajuste_camera_pieds():
	anim.offset = offsetPieds
	targetCamera.position = offsetPieds


#  interactions

func on_objet_body_enter(newObj):
	obj = newObj

func on_objet_body_exit(objOut):
	if objOut == obj :
		obj = null
		
		
# transformations
func deviensLautrec():
	anim.play("transformation")
	nextAnim = "LautrecIdle"
	ajuste_camera_pieds()
	set_isLautrec(true)
	
func deviensLeotardAvecSaut():
	set_isLautrec(false)
	sauteLater = true
	anim.play("transformation")
	nextAnim = "LeoAccroche"
	
func deviensLeotardTrapeze():
	set_isLautrec(false)
	anim.play("transformation")
	nextAnim = "LeoBalance"
	
func set_isLautrec(var b):
	isLautrec = b
	set_collision_layer_bit(1,b)

func _on_AnimatedSprite_animation_finished():
	if nextAnim :
		anim.play(nextAnim)
		nextAnim = null
		if sauteLater:
			sauteLater = false
			if forceSautSpecial :
				saute(forceSautSpecial)
				forceSautSpecial = null
			else :
				saute()
			
# interactions
func set_visible(var b):
	$AnimatedSprite.visible = b

func bloque(var b):
	isBloque = b

func saut_special():
	bloque(true)
	forceSautSpecial = 850
	deviensLeotardAvecSaut()


