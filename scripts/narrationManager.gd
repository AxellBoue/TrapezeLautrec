extends Node2D

onready var pannel = get_node("/root/Node2D/CanvasLayer/Control/Panel")
onready var textBox = pannel.get_node("texteBox")
onready var timer = get_node("Timer")

var texte
var p = 0

export (Array) var intro = [3.5,"""Dans ce lieu de loisir, où le temps semble s'arrêter,
 histoire d'une soirée""", 8.5,"les âmes et les esprits se perdent et s'abreuvent", 
11.5,"oubliant le monde extérieur, histoire d'une soirée.",15]

var cirque = [1,"""Ce lieu magique où le mouvement des corps 
créé une chorégraphie somptueuse.""",5,
"""Les artistes virevoltant de toutes parts, 
tel le grand Léotard  de son vivant.""",10,
"""Cette harmonie fascinante enivre les coeurs 
d’une joie infinie.""",15,]

var hp = [2,"Pourquoi suis-je ici?",5,
"""Ces gens ne veulent pas mon bien.
Ils m'enferment et me maltraitent.""", 10,
"Pourquoi retient on des gens ici?",15]

# Called when the node enters the scene tree for the first time.
func _ready():
	pannel.visible = false
	timer.connect("timeout",self,"change_texte")

func _input(event):
	if event.is_action_pressed("test"):
		pass

func change_texte():
	if p == 0:
		pannel.visible = true
	if 2*p +1 < texte.size() :
		textBox.set_bbcode("[center]"+texte[2*p+1]+"[center]")
		p += 1
		timer.wait_time = texte[2*p]-texte[2*(p-1)]
		timer.start()
	else :
		pannel.visible = false
		timer.stop()
			

func lance_texte(newTexte):
	texte = newTexte
	p = 0
	timer.wait_time = texte[0]
	timer.start()
	

# change la hauteur de la zone texte puis centré ?
# ou change juste marge du haut
