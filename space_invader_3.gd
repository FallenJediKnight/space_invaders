extends "res://scenes/space_invaders/space_invader.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	$AnimatedSprite2D.play("fly")
