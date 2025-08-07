extends Area2D

class_name SpaceInvaderBullet

const SPEED = 300.0

var velocity = Vector2.DOWN

func _physics_process(delta):
	position += velocity * SPEED * delta


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	velocity = Vector2.ZERO
	if area is BunkerPiece:
		visible = false
		area.on_hit()
	else:
		$AnimatedSprite2D.play("explode")
		await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	velocity = Vector2.ZERO
	if body is PlayerShip:
		visible = false
		body.take_damage(get_rid())
	else:
		$AnimatedSprite2D.play("explode")
		await $AnimatedSprite2D.animation_finished
	queue_free()
