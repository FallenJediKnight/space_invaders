extends Node2D

var can_descend = true

func _ready() -> void:
	SignalBus.hit_an_edge.connect(_on_descent_triggered)
	SignalBus.invader_destroyed.connect(_on_invader_destroyed)

func _on_descent_triggered() -> void:
	if can_descend:
		$EdgeTimer.start()
		for invaderRow: SpaceInvaderRow in $Rows.get_children():
			invaderRow.update_all_children_positions()
	can_descend = false

func _on_invader_destroyed(_invader_rid: RID) -> void:
	for invaderRow: SpaceInvaderRow in $Rows.get_children():
			invaderRow.update_all_children_speed()

func _on_edge_timer_timeout() -> void:
	can_descend = true
