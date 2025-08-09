extends Node2D

const MOTHERSHIP_TIMER_MIN = 4
const MOTHERSHIP_TIMER_MAX = 12
const MAX_SCORE = 60

var mothership: Mothership = preload("res://scenes/space_invaders/mothership.tscn").instantiate()
var mothership_timer: Timer = Timer.new()
var mothership_invading = false

func _ready() -> void:
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.player_ship_shoot.connect(_on_player_ship_shoot)
	SignalBus.mothership_retreating.connect(_on_mothership_retreating)
	SignalBus.invader_shoot.connect(_on_invader_shoot)
	SignalBus.update_score.connect(_on_score_updated)
	SignalBus.player_life_lost.connect(_on_player_life_lost)
	
	mothership.set_new_movement_parameters()
	add_child(mothership_timer)
	mothership_timer.timeout.connect(_on_mothership_timer_timeout)
	mothership_timer.one_shot = true
	mothership_timer.wait_time = randi_range(MOTHERSHIP_TIMER_MIN, MOTHERSHIP_TIMER_MAX)
	mothership_timer.start()
	
	$BackgroundMusic.play()


func _process(_delta: float) -> void:
	if $PlayerShip.score == MAX_SCORE:
		call_deferred("game_over", "You win!")


func _on_player_ship_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: PlayerShipBullet = bullet.instantiate()
	spawned_bullet.position = location
	$PlayerBullets.add_child(spawned_bullet)


func _on_invader_shoot(bullet: Resource, location: Vector2) -> void:
	var spawned_bullet: SpaceInvaderBullet = bullet.instantiate()
	spawned_bullet.position = location
	$InvaderBullets.add_child(spawned_bullet)


func _on_game_over() -> void:
	call_deferred("game_over", "Game Over")


func _on_mothership_timer_timeout() -> void:
	if not mothership_invading:
		mothership_invading = true
		add_child(mothership)


func _on_mothership_retreating() -> void:
	mothership_invading = false
	remove_child(mothership)
	mothership.set_new_movement_parameters()
	mothership_timer.wait_time = randi_range(MOTHERSHIP_TIMER_MIN, MOTHERSHIP_TIMER_MAX)
	mothership_timer.start()


func _on_score_updated(score: int) -> void:
	$HUD.update_score(score)


func _on_player_life_lost() -> void:
	$HUD.update_lives($PlayerShip.lives)


func game_over(message: String) -> void:
	$HUD.show_game_over(message)
	get_tree().paused = true


func _on_hud_start_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
