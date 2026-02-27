extends Node2D


const SPEED = 5
var stop = false
var direction: int
var velocity

func _physics_process(delta: float) -> void:
	if stop == false and direction != null:
		velocity = SPEED * Vector2(direction, 0)
		self.position += velocity
