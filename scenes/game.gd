extends Node2D

var game = true

var fishcount: int = 0
var depth: int = 0

@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
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

func retry():
	get_tree().paused = false
	game = true
	depth = 0
	depthcount()
	lastY = 250
	$Death.visible = false
	play_cg()
	
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
	newthing.modulate = Color(randi_range(1, 10), randi_range(1, 10),randi_range(1, 10))
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
		$UI/VBoxContainer/Label.text = "depth: %s" %depth
		
