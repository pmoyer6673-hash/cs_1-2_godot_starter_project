extends Area2D
var speed = 400
var direction = 0


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	pass
	
func _physics_process(delta: float):
	position += speed * direction * delta
	
func set_direction(target):
	direction = position.direction_to(target)
