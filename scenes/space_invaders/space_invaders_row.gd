extends Node2D

class_name SpaceInvaderRow

func update_all_children_positions() -> void:
	for invader: SpaceInvader in get_children():
		invader.descend()


func update_all_children_speed() -> void:
	for invader: SpaceInvader in get_children():
		invader.accelerate()
