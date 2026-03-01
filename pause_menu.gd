extends Control

func _ready():
	pass
func pause():
	get_tree().paused = true
	get_parent().show()
	
func resume():
	get_tree().paused = false
	get_parent().hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()



func _on_resume_pressed() -> void:
	resume()



func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Main Menu.tscn")
	
func _process(delta):
	pass
