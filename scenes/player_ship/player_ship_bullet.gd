extends Area2D

const SPEED = 300.0

var velocity = Vector2.UP

func _physics_process(delta):
	position += velocity * SPEED * delta


func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	velocity = Vector2.ZERO
	if area is SpaceInvader:
		visible = false
		area.explode()
	elif area is BunkerPiece:
		visible = false
		area.on_hit()
	elif area is Mothership:
		visible = false
		area.take_damage(get_rid())
	else:
		$AnimatedSprite2D.play("explode")
		await $AnimatedSprite2D.animation_finished
	queue_free()
