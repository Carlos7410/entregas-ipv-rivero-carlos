extends Sprite

# También realiza el export del PackedScene del proyectil
export (PackedScene) var projectile_scene : PackedScene
var projectile_container:Node
var player

onready var turret_position:Position2D = $TurretPosition

func set_values(player,projectile_container):
	self.player = player
	self.projectile_container = projectile_container
	$Timer.start()

func set_startPosition(new_position):
	$TurretMapLocation.set_position(new_position)
	position = $TurretMapLocation.position

func _on_Timer_timeout():
	fire()
	
func fire():
	var projectile:Projectile = projectile_scene.instance()
	# De nuevo agregando al arbol de nodos para que tome su lugar en pantalla
	projectile_container.add_child(projectile)
	projectile.set_starting_values(turret_position.global_position, (player.global_position - turret_position.global_position).normalized())
	
	projectile.connect("delete_requested", self, "_on_projectile_delete_requested")
	
func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
