extends Node

var das : Position2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.initialize($StartPositionPlayer.position, $ResetTimer)
	$Player.set_projectile_container(self)
	$Turret.set_values(Vector2(self.randomXPos(), self.randomYPos()), self)
	$Turret2.set_values(Vector2(self.randomXPos(), self.randomYPos()), self)
	$Turret3.set_values(Vector2(self.randomXPos(), self.randomYPos()), self)
	
	

func randomXPos():
	return randi() % int($CanvasLayer/Background.get_viewport_rect().size.x)

func randomYPos():
	return randi() % int($Player.position.y - 75)


func _on_Timer_timeout():
	get_tree().reload_current_scene()
