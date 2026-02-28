extends Node2D

@onready var mainbuttons: VBoxContainer = $Mainbuttons
@onready var options: Panel = $Options

func _ready():
	mainbuttons.visible = true
	options.visible = false


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed() -> void:
	mainbuttons.visible = false
	options.visible = true 


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()


func _on_audio_control_value_changed(_value: float) -> void:
	pass # Replace with function body.
