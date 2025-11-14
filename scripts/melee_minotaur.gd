extends CharacterBody2D

var yDirection = 0
var xDirection = 0
var facing = "left"
var in_range = false
var asgoring = false
var whack = false
var speed = 250
var startTime = 1
var timer = startTime
var startTime2 = 2
var timer2 = startTime2
var projectile_original = preload("res://scenes/enemy_arrow.tscn")
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

@onready var player: CharacterBody2D = %Player

func _process(delta: float) -> void:
	velocity.x = xDirection * speed
	velocity.y = yDirection * speed
	if xDirection > 0:
		facing = "right"
	elif xDirection < 0:
		facing = "left"
	elif yDirection < 0:
		facing = "up"
	elif yDirection > 0:
		facing = "down"
	update_animation()
	
	if in_range:
		if timer < 0:
			shoot()
			timer = startTime
		timer -= delta
	elif asgoring:
		position += position.direction_to(player.position) *speed*delta
	if whack:
		if timer2 < 0:
			player.change_health(-2)
			timer2 = startTime2
		timer2 -= delta

func update_animation():
	if whack:
		_animation_player.play("attack_" + facing)
	else:
		if !in_range and !asgoring:
			_animation_player.play("crossbow_idle_" + facing)
		elif asgoring and !whack:
			_animation_player.play("walk_" + facing)

func _on_mlelee_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		whack = true

func _on_mlelee_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		whack = false

func _on_doors_seek_theme_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = false
		asgoring = true

func _on_doors_seek_theme_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		asgoring = false
		in_range = true
		
func _on_nd_amendment_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = true

func _on_nd_amendment_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = false

func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)
