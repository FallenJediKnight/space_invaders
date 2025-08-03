extends Area2D

class_name SpaceInvader

func explode() -> void:
	# TODO add explosion effects: sound
	$AnimatedSprite2D.play("explode", 2.0)
	await $AnimatedSprite2D.animation_finished
	queue_free()
