extends Node2D

@onready var mainbuttons: VBoxContainer = $Mainbuttons
@onready var options: Panel = $Options
@onready var Tutorial2: Panel = $Tutorial2
@onready var Logo: TextureRect = $TextureRect
@onready var Logo2: ColorRect = $ColorRect

func _ready():
	mainbuttons.visible = true
	options.visible = false
	Tutorial2.visible = false
	Logo.visible = true
	Logo2.visible = true
	

func _on_start_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	mainbuttons.visible = false
	options.visible = true 
	Logo.visible = false
	Logo2.visible = false
	

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
	Logo.visible = false
	Logo2.visible = false


func _on_button_pressed() -> void:
	$Mainbuttons/Button_Manager/Start/AudioStreamPlayer.play()

	_ready()


	




func _on_credits_2_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
