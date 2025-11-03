extends CharacterBody2D

var in_range = false
var asgoring = false
var whack = false
var speed = 250
@onready var player: CharacterBody2D = %Player

func _process(delta: float) -> void:
	pass

func _on_mlelee_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_mlelee_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func _on_doors_seek_theme_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_doors_seek_theme_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

func _on_nd_amendment_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_nd_amendment_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
