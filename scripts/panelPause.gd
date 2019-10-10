extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pause():
	get_tree().paused = true
	get_node("CenterContainer/VBoxContainer/Retour").grab_focus()
		

func _on_Retour_pressed():
	visible = false
	get_tree().paused = false

func _on_Recommencer_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_Quitter_pressed():
	get_tree().quit()