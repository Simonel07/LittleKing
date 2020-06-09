extends Node2D


func _ready():
	pass # Replace with function body.

func _on_Spikes_body_entered(body):
	if "Player" in body.name:
		body.damage(25)
