extends Node2D

@onready var player = $Player

func _ready() -> void:
	play_cg()


func _process(delta: float) -> void:
	pass

func play_cg():
	player.stop = true
	$entry.play("fallin")
	await get_tree().create_timer(2.1).timeout
	player.stop = false
