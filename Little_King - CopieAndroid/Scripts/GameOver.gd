extends Control

signal fade_finished

func _ready():
	$AnimationPlayer.play("fade_red")

func fade_in():
	$AnimationPlayer.play("New Anim")
	$Sound.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")
