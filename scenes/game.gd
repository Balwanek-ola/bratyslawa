extends Node2D

var game = true


@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
var positions = [Vector2(-100, 200), Vector2(-100, 450), Vector2(-100, 600), 
Vector2(1700, 200), Vector2(1700, 450), Vector2(1700, 600)]

func _ready() -> void:
	retry()


func _process(delta: float) -> void:
	pass

func retry():
	get_tree().paused = false
	$Death.visible = false
	play_cg()
	startspawning()
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].queue_free()

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false

func spawnthings():
	var r = randi_range(0, 5)
	var newthing = badthing.instantiate()
	$fish.add_child(newthing)
	newthing.position = positions[r]
	if r < 3:
		newthing.direction = 1
	else:
		newthing.direction = -1
	if newthing.position.x > 1700 or newthing.position.x < -100:
		newthing.queue_free()

func startspawning():
	while game:
		spawnthings()
		await get_tree().create_timer(2).timeout

func die():
	$Death.visible = true
	get_tree().paused = true


func _on_retry_pressed() -> void:
	print(retry)
	retry()
