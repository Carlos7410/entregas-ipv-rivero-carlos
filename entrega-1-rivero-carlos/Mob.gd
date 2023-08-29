extends RigidBody2D


# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	# Obteniendo una lista con los nombres de los 3 tipos de animaciones
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	# Numero aleatorio del que obtener el modulo para acceder a uno de los tipos al azar
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


#func _process(delta):
#	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
