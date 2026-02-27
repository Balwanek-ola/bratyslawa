extends Node2D

@onready var player = $Player

var positions = [Vector2(-100, 200), Vector2(-100, 450), Vector2(-100, 600), 
Vector2(1610, 200), Vector2(1610, 450), Vector2(1610, 600)]

func _ready() -> void:
	play_cg()


func _process(delta: float) -> void:
	pass

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false
