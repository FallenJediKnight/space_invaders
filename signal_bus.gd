extends Node

@warning_ignore("unused_signal") signal game_over
@warning_ignore("unused_signal") signal hit_an_edge
@warning_ignore("unused_signal") signal player_ship_shoot(bullet: Resource, location: Vector2)
@warning_ignore("unused_signal") signal invader_destroyed(invader_rid: RID)
@warning_ignore("unused_signal") signal mothership_retreating
@warning_ignore("unused_signal") signal mothership_destroyed
@warning_ignore("unused_signal") signal invader_shoot(bullet: Resource, location: Vector2)
@warning_ignore("unused_signal") signal update_score(score: int)
@warning_ignore("unused_signal") signal player_life_lost
