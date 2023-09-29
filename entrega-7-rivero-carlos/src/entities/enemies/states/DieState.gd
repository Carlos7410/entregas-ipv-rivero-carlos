extends AbstractState


func enter() -> void:
	# Setear variables correspondientes a la muerte
	#character._play_animation("dead")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
	# Usando la animación de muerte correspondiente a sí estaba en alert o no
	if character.target != null:
		character._play_animation("die_alert")
	else:
		character._play_animation("die")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name in ["die", "die_alert"]:
		character._remove()
