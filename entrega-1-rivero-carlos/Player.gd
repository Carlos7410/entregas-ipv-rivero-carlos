extends Area2D

signal hit
	
	
# Declare member variables here.
export var speed = 400
var screen_size 


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func start(pos):
	position = pos
	show()
	# Quitando el deshabilitado de la colisión al comienzo de cada partida
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# También usada para saber si debe continuar reproduciendo la animación
	if velocity.length() > 0:
		# Dado que moverse en dos direcciones a la vez aumenta la velocidad, se debe normalizar
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_Player_body_entered(_body):
	hide() # Desaparecer al nodo Player cuando se produce un hit
	emit_signal("hit")
	# Con el objetivo de desactivar la colisión de Player para no emitir la señal nuevamente
	$CollisionShape2D.set_deferred("disabled", true)
