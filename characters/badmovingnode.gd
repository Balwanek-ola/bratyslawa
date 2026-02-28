extends Node2D
class_name enemy

@export var SPEED = 2
@export var speedUP = 5
var stop = false
var direction: int
var velocity
var velocityUp
var inAbility: bool = false
var dead = false

func _ready() -> void:
	$Icon.play("idle")
	
func _physics_process(delta: float) -> void:
	if stop == false and direction != null:
		velocity = SPEED * direction
		velocityUp = speedUP * -1
		self.scale.x = direction
		self.position.x += velocity
		self.position.y += velocityUp

func die():
	stop = true
	dead = true
	$AnimationPlayer.play("die")
	await get_tree().create_timer(1.2).timeout
	self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not dead:
		body.hit()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
