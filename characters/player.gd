extends CharacterBody2D

@onready var game
@export var lightnode: PointLight2D
@export var HBar: Node2D
@export var aniplay: AnimationPlayer

const SPEED = 500.0
var stop = false

var health = 3
var MxHealth = 3

var immune = false

func _ready() -> void:
	$Icon.play("idle")
	game = get_parent()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if game.light >= game.costl:
			game.light -= game.costl
			game.ability()

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
		match game.light:
			0: 
				lightnode.texture_scale = 1
			1:
				lightnode.texture_scale = 1.5
			2:
				lightnode.texture_scale = 2
			3:
				lightnode.texture_scale = 3
			4:
				lightnode.texture_scale = 4
				
		game.lightcount()

func hit():
	
	if not immune:
		immune = true
		health -= 1
		HBar.setvalue(health)
		if health == 0:
			die()
		else:
			aniplay.play("hit")
			await get_tree().create_timer(0.8).timeout
		immune = false
	
func die():
	$Icon.play("died")
	stop = true
	get_tree().paused = true
	var gamescene = get_parent()
	gamescene.game = false
	if gamescene != null and gamescene.name == "Game":
		aniplay.play("death")
		await get_tree().create_timer(1.2).timeout
		get_tree().paused = false
		$Icon.play("idle")
		gamescene.die()



func _on_ability_area_entered(area: Area2D) -> void:
	if area.name == "enemy":
		area.get_parent().inAbility = true
	


func _on_ability_area_exited(area: Area2D) -> void:
	if area.name == "enemy":
		area.get_parent().inAbility = false
