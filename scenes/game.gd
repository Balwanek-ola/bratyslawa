extends Node2D

var game = true

var fishcount: int = 0
var depth: int = 0
var light: int = 0
var costl = 4
var maxFish = 20

@onready var player = $Player
#@onready var badthing = preload(res://characters/badmoving.tscn)
@export var badthing: PackedScene
@export var swordfish: PackedScene
@export var lightthing: PackedScene
@export var sillydih: PackedScene
@export var mareczek: PackedScene
@export var tenma: PackedScene
@export var johnfih: PackedScene


@export var obstacle1: Sprite2D
@export var obstacle2: Sprite2D
@export var obstacle3: Sprite2D

var currentfih1: PackedScene
var currentfih2: PackedScene

var lastY = 400
var positions: Array

func _ready() -> void:
	generate_pos()
	retry()
	obstacles()
	


func _physics_process(delta: float) -> void:
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			if fish[i].position.x > 1800 or fish[i].position.x < -200:
				fish[i].queue_free()
				fishcount -= 1
	fish = $sword.get_children()
	if fish != null:
		for i in range(fish.size()):
			if fish[i].position.x > 1800 or fish[i].position.x < -200:
				fish[i].queue_free()
				fishcount -= 1
	var light = $light.get_children()
	if light != null:
		for i in range(light.size()):
			light[i].position.y -= 350 * delta

func retry():
	currentfih1 = badthing
	currentfih2 = swordfish
	get_tree().paused = false
	game = true
	depth = 0
	light = 0
	player.health = player.MxHealth
	player.HBar.setvalue(player.MxHealth)
	$UI/Light.value = 0
	depthcount()
	lastY = 250
	$Death.visible = false
	play_cg()
	startlighting()
	$fader.play("RESET")
	played1 = false
	played2 = false
	played3 = false
	
	
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			fish[i].queue_free()
			fishcount -= 1
	
	fish = $sword.get_children()
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
	var newthing = currentfih1.instantiate()
	$fish.add_child(newthing)
	fishcount += 1
	newthing.position.y = positions[r]
	if ry == 0:
		newthing.direction = 1
		newthing.position.x = -100
	else:
		newthing.direction = -1
		newthing.position.x = 1700
	
	r = randi_range(0, 9)
	ry = randi_range(0, 1)
	newthing = currentfih2.instantiate()
	$sword.add_child(newthing)
	fishcount += 1
	newthing.position.y = positions[r]
	if ry == 0:
		newthing.direction = 1
		newthing.position.x = -100
	else:
		newthing.direction = -1
		newthing.position.x = 1700

func startspawning():
	while game:
		if fishcount < maxFish:
			spawnthings()
		await get_tree().create_timer(0.2).timeout

func spawn_light():
	var newlight = lightthing.instantiate()
	$light.add_child(newlight)
	var r = randi_range(0, 3)
	match r:
		0:
			newlight.position = Vector2(200, 1000)
		1:
			newlight.position = Vector2(600, 1000)
		2:
			newlight.position = Vector2(1000, 1000)
		3:
			newlight.position = Vector2(1400, 1000)

func startlighting():
	while game:
		await get_tree().create_timer(7).timeout
		spawn_light()
		

func die():
	if depth > SaveLoad.high_score:
		SaveLoad.high_score = depth
		SaveLoad._save()
	$Death.visible = true
	get_tree().paused = true
	game = false


func _on_retry_pressed() -> void:
	retry()

var played1 = false
var played2 = false
var played3 = false

func depthcount():
	while game:
		if depth < 100:
			maxFish = 20
		elif depth > 99 and depth < 250:
			if not played1:
				maxFish = 0
				$fader.play("fade1")
				played1 = true
				currentfih1 = sillydih
				currentfih2 = mareczek
				newlayer(40)
		elif depth > 249 and depth < 500:
			if not played2:
				maxFish = 0
				$fader.play("fade2")
				played2 = true
				currentfih1 = tenma
				currentfih2 = johnfih
				newlayer(60)
		if get_tree().paused == false:
			await get_tree().create_timer(0.3).timeout
			depth += 1
		$UI/depth.text = "%sm" %depth
		
func newlayer(newMax: int):
	await get_tree().create_timer(5).timeout
	maxFish = newMax

func lightcount():
	if light < 4:
		light += 1
	$UI/Light.value = light


func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main Menu.tscn")

func ability():
	var fish = $fish.get_children()
	if fish != null:
		for i in range(fish.size()):
			if fish[i].inAbility:
				fish[i].die()
				fishcount -= 1
	fish = $sword.get_children()
	if fish != null:
		for i in range(fish.size()):
			if fish[i].inAbility:
				fish[i].die()
				fishcount -= 1

		
func obstacles():
	while game:
		var obs
		await get_tree().create_timer(5).timeout
		var r = randi_range(0,2)
		match r:
			0:
				obs = obstacle1
			1:
				obs = obstacle2
			2:
				obs = obstacle3
		
		var p = randi_range(0, 1)
		match p:
			0:
				obs.position.x = -50
				obs.flip_h = false
			1:
				obs.position.x = 1250
				obs.flip_h = true
		obs.position.y = 1200
		var tween = create_tween()
		tween.tween_property(obs,"position", Vector2(obs.position.x,- 500),3)
	


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		body.die()
