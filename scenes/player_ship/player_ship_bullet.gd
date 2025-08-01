extends Area2D

const SPEED = 300.0

var velocity = Vector2.UP

func _physics_process(delta):
	position += velocity * SPEED * delta
