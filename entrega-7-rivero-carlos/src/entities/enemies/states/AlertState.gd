extends AbstractTurretState

onready var fire_timer = $FireTimer


func enter() -> void:
	character.velocity = Vector2.ZERO
	fire()

func fire() -> void:
	character._fire()
	character._play_animation("attack")

func update(delta : float) -> void:
	character._look_at_target()


func _on_animation_finished(anim_name: String) -> void:
	if character.target == null:
		emit_signal("finished", "idle")
	else:
		match anim_name:
			# Al terminar animación de ataque, el pasaje a "alert" permite tener 
			# un cooldown entre los ataques
			"attack":
				character._play_animation("alert")
			# Lo que dura "alert" que se usará como cooldown, al finalizar
			# se vuelve a evaluar si disparar de nuevo o volver a idle 
			"alert":
				if character._can_see_target():
					fire()
				else:
					emit_signal("finished", "idle")


func _handle_body_exited(body : Node) -> void:
	._handle_body_exited(body)
	# Sinergia con anterior método; dado que el pasaje entre attack y alert ya genera
	# un pasaje a idle natural al terminar si no encuentra al target, solo se hace
	# el cambio al salir el player si no se encuentra en la animación de "attack"
	if character.target == null:
		if character.get_current_animation() != "attack	":
			emit_signal("finished", "idle")



