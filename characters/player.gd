extends CharacterBody2D


const SPEED = 500.0
var stop = false

func _physics_process(delta: float) -> void:
	if stop == false:
		var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = input_vector * SPEED
#		if input_vector.y == 1:
#			velocity*= 1.5
#		elif input_vector.y -- -1:
#			velocity*= 0.5
		move_and_slide()

func hit():
	die()
	
func die():
	var gamescene = get_parent()
	if gamescene != null and gamescene.name == "Game":
		gamescene.die()
	
