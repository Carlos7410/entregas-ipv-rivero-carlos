extends Sprite

class_name Projectile

var camera:CanvasLayer
# Esta dirección debe ser normalizada
var direction:Vector2
var impact_body:Node2D
export (float) var speed

signal delete_requested(projectile)

func addCameraControl(camera):
	self.camera = camera

func _ready():
	set_physics_process(false)
	
func set_starting_values(starting_position:Vector2, direction:Vector2):
	global_position = starting_position
	self.direction = direction
	$Timer.start()
	set_physics_process(true)
	

func _physics_process(delta):
	position += direction * speed * delta


func _on_Timer_timeout():
	emit_signal("delete_requested", self)


func _on_Area2D_body_entered(body):
	impact_body = body
	impact_body.disappearItself()
