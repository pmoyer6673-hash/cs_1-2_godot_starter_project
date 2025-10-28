extends Area2D
var Active = false
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "Player":
		Active = true
		body.change_health(-2)
		update_animation()

func update_animation():
	if Active:
		_animation_player.play("on")
	else:
		_animation_player.play("off")
