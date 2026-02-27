extends CharacterBody2D


const SPEED = 500.0
var stop = false

func _physics_process(delta: float) -> void:
	if stop == false:
		var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_vector * SPEED
		move_and_slide()
