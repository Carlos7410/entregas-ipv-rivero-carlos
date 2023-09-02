extends Node

var das : Position2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.start($StartPositionPlayer.position)
	$Player.set_projectile_container(self)
	$Turret.set_startPosition(Vector2(self.randomXPos(), self.randomYPos()))
	$Turret2.set_startPosition(Vector2(self.randomXPos(), self.randomYPos()))
	$Turret3.set_startPosition(Vector2(self.randomXPos(), self.randomYPos()))
	$Turret.set_values($Player,self)
	$Turret2.set_values($Player,self)
	$Turret3.set_values($Player,self)
	

func randomXPos():
	return randi() % int($Background.get_viewport_rect().size.x)

func randomYPos():
	return randi() % int($Player.position.y - 75)
