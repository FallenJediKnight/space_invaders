extends Area2D

class_name Mothership

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()
