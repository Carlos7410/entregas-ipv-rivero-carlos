extends Node

export(PackedScene) var mob_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _on_Player_hit():
	game_over()

func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	# En la siguiente linea se resetearía la puntuación para cada nueva partida
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	
	var mob = mob_scene.instance()
	
	# Obteniendo ubicación random en Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Setear la dirección perpendicular del mob a la dirección del path
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Asignando la posición de spawn al mob
	mob.position = mob_spawn_location.position
	
	# Agregando aleatoridad a la dirección, un rango aleatorio
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Seteando la velocidad del mob
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawnear mob al añadirlo a la escena main
	add_child(mob)

