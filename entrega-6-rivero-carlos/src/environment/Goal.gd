extends Area2D

onready var finish_animation = $FinishAnimation


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node) -> void:
	print("You win!")
	disconnect("body_entered", self, "_on_body_entered")
	_play_animation("finish")




func _play_animation(animation: String) -> void:
	if finish_animation.has_animation(animation):
		finish_animation.play(animation)


func _on_FinishAnimation_animation_finished(anim_name):
	if anim_name == "finish":
		_play_animation("loopportal")
