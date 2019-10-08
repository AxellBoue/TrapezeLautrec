extends Area2D

onready var camera = get_node("/root/Node2D/gameManager/cameraBox")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_zoneCamera_body_entered(body):
	if body.name == "Lautrec":
		camera.target2 = $targetZone
		camera.change_target(camera.moyenne)

func _on_zoneCamera_body_exited(body):
	if body.name == "Lautrec":
		camera.change_target(body)
