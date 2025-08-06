extends Node2D

var can_descend = true

func _ready() -> void:
	SignalBus.hit_an_edge.connect(trigger_descent)

func trigger_descent() -> void:
	if can_descend:
		$EdgeTimer.start()
		for invaderRow: SpaceInvaderRow in $Rows.get_children():
			invaderRow.update_all_children_positions()
	can_descend = false


func _on_edge_timer_timeout() -> void:
	can_descend = true
