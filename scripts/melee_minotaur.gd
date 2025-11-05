extends CharacterBody2D

var in_range = false
var asgoring = false
var whack = false
var speed = 250
var projectile_original = preload("res://scenes/enemy_arrow.tscn")

@onready var player: CharacterBody2D = %Player

func _process(delta: float) -> void:
	if in_range:
		shoot()
	pass

func _on_mlelee_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		whack = true

func _on_mlelee_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		whack = false

func _on_doors_seek_theme_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false
		asgoring = true

func _on_doors_seek_theme_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		asgoring = false
		
func _on_nd_amendment_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_range = true

func _on_nd_amendment_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_range = false

func shoot():
	var projectile_clone = projectile_original.instantiate()
	projectile_clone.global_position = position
	projectile_clone.set_direction(player.position)
	get_tree().get_root().add_child(projectile_clone)
