extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()

func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		print("DZIALA")
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()



func _on_resume_pressed() -> void:
	resume()



func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Main Menu.tscn")
	
func _process(delta):
	testEsc()
