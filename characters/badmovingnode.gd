extends Node2D


const SPEED = 5
var stop = false
var direction: int
var velocity

func _physics_process(delta: float) -> void:
	if stop == false and direction != null:
		velocity = SPEED * Vector2(direction, 0)
		self.position += velocity


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.hit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
