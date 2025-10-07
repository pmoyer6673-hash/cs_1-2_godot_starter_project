extends CharacterBody2D
var Player
var in_radius = false
var startTime = 1
var timer = startTime
var projectile_original = preload("res://scenes/enemy_projectile.tscn")

func _ready():
	
	pass

func _process(delta: float) -> void:
	if in_radius == true:
		if timer < 0:
			shoot(Player)
			timer = startTime
		timer -= delta


	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Player = body
		in_radius= true
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_radius = false

func shoot(target):
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(target.position)
	get_tree().get_root().add_child(projectile_clone)
