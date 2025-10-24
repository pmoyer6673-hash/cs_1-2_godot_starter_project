extends Area2D
var Active = false
@onready var _animation_player: AnimatedSprite2D = $AnimatedSprite2D

func update_animation():
	if Active:
		_animation_player.play("on")
	else:
		_animation_player.play("off")
