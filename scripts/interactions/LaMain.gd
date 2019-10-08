extends AnimatedSprite

var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	play("bouge")
	
	
func interaction():
	play("interaction")
	active = true
	get_node("capte leotard").queue_free()
	
func next_anim():
	if active :
		play("boucleFin")


