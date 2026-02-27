extends Node2D

var game = true

var fishcount: int = 0

@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
var lastY = 400
#var positions = [Vector2(-100, 200), Vector2(-100, 450), Vector2(-100, 600), Vector2(1700, 200), Vector2(1700, 450), Vector2(1700, 600)]

func _ready() -> void:
	retry()


func _process(delta: float) -> void:
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			if fish[i].position.x > 1800 or fish[i].position.x < -200:
				fish[i].queue_free()
				fishcount -= 1
	$fish.position.y -= 50 * delta

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
	var r = randi_range(0, 1)
	var newthing = badthing.instantiate()
	$fish.add_child(newthing)
	fishcount += 1
	if r == 0:
		newthing.direction = 1
		newthing.position = Vector2(-100, lastY) 
		lastY =+ randi_range(150, 300)
	else:
		newthing.direction = -1
		newthing.position = Vector2(1700, lastY) 
		lastY =+ randi_range(300, 800)

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
