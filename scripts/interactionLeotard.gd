extends Area2D

onready var parent = get_node("../")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_capte_leotard_body_entered(body):
	if body.name == "Lautrec":
		parent.interaction()


func _on_capte_leotard_body_exited(body):
	pass # Replace with function body.
