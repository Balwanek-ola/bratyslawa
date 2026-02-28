extends Node2D

var game = true

var fishcount: int = 0

@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
var lastY = 400
var positions = [Vector2(-100, 400), Vector2(-100, 650), Vector2(-100, 800), 
Vector2(1700, 400), Vector2(1700, 650), Vector2(1700, 800)]

func _ready() -> void:
	retry()


func _process(delta: float) -> void:
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].position.y -= 100 * delta
			if fish[i].position.x > 1800 or fish[i].position.x < -200:
				fish[i].queue_free()
				fishcount -= 1

func retry():
	get_tree().paused = false
	lastY = 250
	$Death.visible = false
	play_cg()
	startspawning()
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].queue_free()
			fishcount -= 1

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false

func spawnthings():
	var r = randi_range(0, 5)
	var newthing = badthing.instantiate()
	$fish.add_child(newthing)
	fishcount += 1
	newthing.position = positions[r]
	if r < 3:
		newthing.direction = 1
#		newthing.position = Vector2(-100, lastY) 
#		lastY =+ randi_range(150, 300)
	else:
		newthing.direction = -1
#		newthing.position = Vector2(1700, lastY) 
#		lastY =+ randi_range(600, 800)

func startspawning():
	while game:
		if fishcount < 9:
			spawnthings()
		await get_tree().create_timer(1.5).timeout

func die():
	$Death.visible = true
	get_tree().paused = true


func _on_retry_pressed() -> void:
	retry()
