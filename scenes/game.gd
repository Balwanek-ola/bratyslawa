extends Node2D

var game = true

var fishcount: int = 0
var depth: int = 0
var light: int = 0

@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
@export var lightthing: PackedScene
var lastY = 400
var positions: Array

func _ready() -> void:
	generate_pos()
	retry()


func _process(delta: float) -> void:
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].position.y -= 150 * delta
			if fish[i].position.x > 1800 or fish[i].position.x < -200:
				fish[i].queue_free()
				fishcount -= 1
	var light = $light.get_children()
	if light != null:
		for i in range(light.size()):
			light[i].position.y -= 350 * delta

func retry():
	get_tree().paused = false
	game = true
	depth = 0
	depthcount()
	lastY = 250
	$Death.visible = false
	play_cg()
	startlighting()
	
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].queue_free()
			fishcount -= 1

func generate_pos():
	var a = 350
	for i in range(10):
		positions.append(a)
		a += 200

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false
	startspawning()

func spawnthings():
	var r = randi_range(0, 9)
	var ry = randi_range(0, 1)
	var newthing = badthing.instantiate()
	$fish.add_child(newthing)
	fishcount += 1
	newthing.position.y = positions[r]
	if ry == 0:
		newthing.direction = 1
		newthing.position.x = -100
	else:
		newthing.direction = -1
		newthing.position.x = 1700

func startspawning():
	while game:
		if fishcount < 100:
			spawnthings()
		await get_tree().create_timer(0.2).timeout

func spawn_light():
	var newlight = lightthing.instantiate()
	$light.add_child(newlight)
	var r = randi_range(0, 3)
	match r:
		0:
			newlight.position = Vector2(100, 1000)
		1:
			newlight.position = Vector2(200, 1000)
		2:
			newlight.position = Vector2(1400, 1000)
		3:
			newlight.position = Vector2(1500, 1000)

func startlighting():
	while game:
		spawn_light()
		await get_tree().create_timer(5).timeout

func die():
	$Death.visible = true
	get_tree().paused = true
	game = false


func _on_retry_pressed() -> void:
	retry()

func depthcount():
	while game:
		await get_tree().create_timer(0.5).timeout
		depth += 1
		$UI/VBoxContainer/Label.text = "depth: %sm" %depth
		
func lightcount():
	light += 1
	$UI/VBoxContainer/Label2.text = "light: %s" %light


func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main Menu.tscn")
