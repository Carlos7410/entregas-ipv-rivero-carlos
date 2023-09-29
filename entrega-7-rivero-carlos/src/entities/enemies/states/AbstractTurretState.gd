extends AbstractState

class_name AbstractTurretState


func handle_event(event : String, value = null) -> void:
	match event:
		"body_entered":
			_handle_body_entered(value)
		"body_exited":
			_handle_body_exited(value)

func _handle_body_entered(body : Node) -> void:
	if character.target == null && !character.dead:
		character.target = body
		character._play_animation("alert")
	
func _handle_body_exited(body : Node) -> void:
	if character.target == body && !character.dead:
		character.target = null
		
		character._play_animation("go_normal")
