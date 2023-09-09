extends KinematicBody2D

export (PackedScene) var projectile_scene : PackedScene
var projectile_container:Node
var target:Node2D

onready var fire_timer = $FireTimer
onready var turret_position:Position2D = $TurretMapLocation
onready var fire_position:Position2D = $FirePosition

func set_values(position, projectile_container):
	self.set_startPosition(position)
	self.projectile_container = projectile_container
	

func set_startPosition(new_position):
	$TurretMapLocation.set_position(new_position)
	position = $TurretMapLocation.position

func _on_Timer_timeout():
	fire_at_target()
	
func fire_at_target():
	var projectile:Projectile = projectile_scene.instance()
	# De nuevo agregando al arbol de nodos para que tome su lugar en pantalla
	projectile_container.add_child(projectile)
	projectile.set_starting_values(fire_position.global_position, (target.global_position - fire_position.global_position).normalized())
	
	projectile.connect("delete_requested", self, "_on_projectile_delete_requested")
	
	
func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()


func _on_DetectionArea_body_entered(body):
	target = body
	fire_timer.start()

func _on_DetectionArea_body_exited(body):
	fire_timer.stop()
	
func disappearItself():
	self.queue_free()
