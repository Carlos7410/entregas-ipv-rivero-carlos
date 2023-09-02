extends Sprite


export var speed = 300

onready var cannon:Sprite = $Cannon
var projectile_container : Node

func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container


func _process(delta):
	
	
	# En lugar de usar la global en ambas, se puede transformar a local la posicion del mouse 
	# debido a que no funciona correctamente la local
	var mouse_position:Vector2 = get_global_mouse_position()
	
	# Manera compleja de obtener orientación del cañon
	# Resta Vector B - A (Destino - Origen)
	var mouse_cannon_orientation:Vector2 = to_local(mouse_position) - cannon.position
	cannon.rotation = mouse_cannon_orientation.angle()
	
	# Manera abreviada usando función built-in de Godot
	#cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		$Cannon.fire()
	
	# Movement
	var direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	position.x += direction * speed * delta
	

func start(pos):
	position = pos
