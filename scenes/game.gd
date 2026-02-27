extends Node2D

@onready var player = $Player

#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
var positions = [Vector2(-100, 200), Vector2(-100, 450), Vector2(-100, 600), 
Vector2(1610, 200), Vector2(1610, 450), Vector2(1610, 600)]

func _ready() -> void:
	play_cg()
	spawnthings()


func _process(delta: float) -> void:
	pass

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false

func spawnthings():
	var r = randi_range(0, 5)
	var newthing = badthing.instantiate()
	add_child(newthing)
	newthing.position = positions[r]
	if r < 3:
		newthing.direction = 1
	else:
		newthing.direction = -1
