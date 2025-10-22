extends CharacterBody2D
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D
var projectile_original = preload("res://scenes/projectile.tscn")

var xSpeed = 300.0
var xDirection = 0
var facing = "down"
var ySpeed = 300.0
var yDirection = 0
var coins = 0
@export var offset : Vector2 = Vector2(0, -25)
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var melee_hitbox: Area2D = $Area2D
# TODO: Add health system variables
var maxHealth = 10
var health = maxHealth
var Is_attacking = false
var attack_Timer = 0.6
var current_Enemy
var playerInRange = false
var current_Lever

func _ready() -> void:
	pass

func _physics_process(_delta):
	# TODO: Get horizontal input (left/right keys)
	# Input.get_axis checks two keys and gives us a number:
	# - When LEFT is pressed: returns -1.0
	# - When RIGHT is pressed: returns 1.0  
	# - When NOTHING is pressed: returns 0.0
	xDirection = Input.get_axis("ui_left", "ui_right")
	
	# TODO: Get vertical input (up/down keys)  
	# Same idea, but for up and down movement
	yDirection = Input.get_axis("ui_up", "ui_down")
	
	# TODO: Set the player's velocity (how fast they're moving)
	# Godot's CharacterBody2D uses a velocity system
	#velocity is a vector, define it as a product of speed and direction
	velocity.x = xDirection * xSpeed
	velocity.y = yDirection * ySpeed
	
	# TODO: Update facing direction based on movement
	if xDirection > 0:
		facing = "right"
		melee_hitbox.position = Vector2(30,10)
	elif xDirection < 0:
		facing = "left"
		melee_hitbox.position = Vector2(-30,10)
	elif yDirection < 0:
		facing = "up"
		melee_hitbox.position = Vector2(0,-40)
	elif yDirection > 0:
		facing = "down"
		melee_hitbox.position = Vector2(0,30)

	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input .is_action_just_pressed("melee"):
		Is_attacking = true
	if Is_attacking:
		attack_Timer -= _delta
	if attack_Timer < 0:
		Is_attacking = false
		attack_Timer = 0.67
	# call the animation function
	update_animation()
	
	
	# This is a special Godot function that makes the movement happen
	move_and_slide()

# TODO: Create animation function (add this outside of _physics_process)
func update_animation():
	if Is_attacking:
		_animation_player.play("attack_" + facing)
	else:
		if velocity.is_zero_approx():
			_animation_player.play("idle_" + facing)
		elif !velocity.is_zero_approx():
			_animation_player.play("walk_" + facing)
		
	


# TODO: Create health change function for interactions
func change_health(_amount:int):
		health += _amount
		if health < 1:
			die()
		if health > maxHealth:
			health = maxHealth
		print("Health: ", health)

func change_coins(_amount:int):
	coins += _amount
	print("you have " +str(coins) +" coins")

func die():
	print("you died")
	queue_free()
# TODO: Create shooting function
func shoot():
	# TODO: Create a new projectile instance
	var projectile_clone = projectile_original.instantiate()
	
	# TODO: Set projectile position to player position
	projectile_clone.global_position = position + offset
	
	# TODO: Set projectile direction using facing variable
	projectile_clone.set_direction(facing)
	
	# TODO: Add projectile to the game world
	get_tree().get_root().add_child(projectile_clone)

	pass

func _process(delta: float):
	if Is_attacking and current_Enemy != null:
		current_Enemy.queue_free()
	if Is_attacking and current_Lever != null:
		current_Lever.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		current_Enemy = body
	if body.is_in_group("LEVERE"):
		current_Lever = body
