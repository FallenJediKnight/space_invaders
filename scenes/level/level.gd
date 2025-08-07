extends Node2D


var mothership: Mothership = preload("res://scenes/space_invaders/mothership.tscn").instantiate()
var mothership_invading = false

func _ready() -> void:
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.player_ship_shoot.connect(_on_player_ship_shoot)
	SignalBus.mothership_retreating.connect(_on_mothership_retreating)
	SignalBus.invader_shoot.connect(_on_invader_shoot)
	$BackgroundMusic.play()


func _on_player_ship_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: PlayerShipBullet = bullet.instantiate()
	spawned_bullet.position = location
	$PlayerBullets.add_child(spawned_bullet)


func _on_invader_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: SpaceInvaderBullet = bullet.instantiate()
	spawned_bullet.position = location
	$InvaderBullets.add_child(spawned_bullet)


func _on_game_over() -> void:
	call_deferred("game_over")


func _on_mothership_timer_timeout() -> void:
	if not mothership_invading:
		mothership_invading = true
		add_child(mothership)


func _on_mothership_retreating() -> void:
	mothership_invading = false
	remove_child(mothership)
	mothership.set_new_movement_parameters()


func game_over() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
