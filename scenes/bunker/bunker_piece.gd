extends Area2D

class_name BunkerPiece

func on_hit() -> void:
	queue_free()
