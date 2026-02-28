extends CharacterBody2D

@onready var game

const SPEED = 500.0
var stop = false

func _ready() -> void:
	$Icon.play("idle")
	game = get_parent()

func _physics_process(delta: float) -> void:
	var input_vector:= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if stop == false:
		velocity = input_vector * SPEED
#		if input_vector.y == 1:
#			velocity*= 1.5
#		elif input_vector.y -- -1:
#			velocity*= 0.5
	if input_vector != null:
		if input_vector.x > 0:
			$Icon.flip_h = true
		elif input_vector.x < 0:
			$Icon.flip_h = false
		move_and_slide()

func light():
	if game != null:
		game.lightcount()

func hit():
	die()
	
func die():
	var gamescene = get_parent()
	if gamescene != null and gamescene.name == "Game":
		gamescene.die()
	


func _on_ability_area_entered(area: Area2D) -> void:
	pass
