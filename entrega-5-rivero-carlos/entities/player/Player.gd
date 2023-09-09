extends KinematicBody2D


export (float) var ACCELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 450.0
export (float) var FRICTION_WEIGHT:float = 0.1
export (float) var JUMP_SPEED:float = -270
export (float) var GRAVITY:float = 8
var velocity:Vector2 = Vector2.ZERO
var timerControl:Timer


onready var cannon:Sprite = $Cannon
var projectile_container : Node


func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container


func _physics_process(delta):
	
	# Rotación de cañon
	var mouse_position:Vector2 = get_global_mouse_position()
	
	# Manera compleja de obtener orientación del cañon
	# Resta Vector B - A (Destino - Origen)
	var mouse_cannon_orientation:Vector2 = to_local(mouse_position) - cannon.position
	cannon.rotation = mouse_cannon_orientation.angle()
	
	if Input.is_action_just_pressed("fire"):
		$Cannon.fire()
	
	# Movement
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
		
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
	
	velocity.y += GRAVITY
	move_and_slide(velocity, Vector2.UP)
	
func initialize(pos, timer):
	position = pos
	timerControl = timer
	
func disappearItself():
	$Camera2D.current = false
	timerControl.start()
	queue_free()

