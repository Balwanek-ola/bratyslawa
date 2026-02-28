extends Node2D

@onready var mainbuttons: VBoxContainer = $Mainbuttons
@onready var options: Panel = $Options
@onready var Tutorial2: Panel = $Tutorial2
@onready var Credits: Panel = $Options/Credits2/Credits

func _ready():
	mainbuttons.visible = true
	options.visible = false
	Tutorial2.visible = false
	Credits.visible = false

func _on_start_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	mainbuttons.visible = false
	options.visible = true 
	

func _on_quit_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	get_tree().quit()


func _on_back_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	_ready()


func _on_audio_control_value_changed(_value: float) -> void:
	pass # Replace with function body.


func _on_tutorial_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	mainbuttons.visible = false
	Tutorial2.visible = true


func _on_button_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	_ready()


	


func _on_credits2_pressed() -> void:
	mainbuttons.visible = false
	Tutorial2.visible = false
	options.visible = false
	Credits.visible = true


func _on_credits_2_pressed() -> void:
	pass # Replace with function body.
