extends Area2D

class_name SpaceInvader

var speed = 30.0
var right_edge_delta = 85
var left_edge_delta = 32
var descend_delta = 32
var direction = Vector2.RIGHT

func _process(delta: float) -> void:
	if has_hit_an_edge():
		SignalBus.hit_an_edge.emit()
	var position_delta = direction * speed * delta
	position += position_delta
	
func descend() -> void:
	position += Vector2(0, descend_delta)
	direction = direction.rotated(deg_to_rad(180))

func has_hit_an_edge() -> bool:
	return (position.x > get_viewport_rect().end.x - right_edge_delta) or (position.x < get_viewport_rect().position.x - left_edge_delta)

func explode() -> void:
	# TODO add explosion effects: sound
	$AnimatedSprite2D.play("explode", 2.0)
	await $AnimatedSprite2D.animation_finished
	queue_free()
