extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	$Particles2D.emitting = true
	$Particles2D/Particles2D2.emitting = true
	$Particles2D/Particles2D.emitting = true
	$Particles2D/Particles2D3.emitting = true
