extends Area2D
var Active = false



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Active = true
		queue_free()
