extends Node2D

@export var speed = 30.0
@export var right_edge_delta = 85
@export var descend_delta = 32

var direction = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	if get_right_most_child_position().x > get_viewport_rect().end.x - right_edge_delta:
		update_all_children_positions()
		direction = Vector2.LEFT
	
	if get_left_most_child_position().x < get_viewport_rect().position.x - 32:
		update_all_children_positions()
		direction = Vector2.RIGHT
	
	for invader: Area2D in get_children():
		var position_delta = direction * speed * delta
		invader.position += position_delta

func update_all_children_positions() -> void:
	for invader: Area2D in get_children():
		var position_delta = Vector2(0, descend_delta)
		invader.position += position_delta

func get_right_most_child_position() -> Vector2:
	var right_most_child_position = Vector2(0, 0)
	for invader: Area2D in get_children():
		if invader.position.x > right_most_child_position.x:
			right_most_child_position = invader.position
	return right_most_child_position
	
func get_left_most_child_position() -> Vector2:
	var left_most_child_position = Vector2(0, 0)
	for invader: Area2D in get_children():
		if invader.position.x < left_most_child_position.x:
			left_most_child_position = invader.position
	return left_most_child_position
