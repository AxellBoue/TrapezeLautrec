extends Area2D

var destroy = false
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("balance")
	sprite = get_node("sprite")
	#connect("body_entered",get_node("Lautrec"),"attrape_trapeze")

func _physics_process(delta):
	if destroy :
		sprite.modulate = Color(1,1,1,sprite.modulate.a - 0.01)
		if sprite.modulate.a <= 0 :
			queue_free()

func trapeze_destroy():
	destroy = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
