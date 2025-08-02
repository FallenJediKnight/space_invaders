extends Area2D

const SPEED = 300.0

var velocity = Vector2.UP

func _physics_process(delta):
	position += velocity * SPEED * delta


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is SpaceInvader or BunkerPiece:
		# TODO add explosion effects: sound and animation
		area.queue_free()
		queue_free()
