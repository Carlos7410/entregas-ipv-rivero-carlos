extends Area2D


export var speed = 300
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("mover_izq"):
		velocity.x -= 1
	if Input.is_action_pressed("mover_der"):
		velocity.x += 1
	
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	

func start(pos):
	position = pos
