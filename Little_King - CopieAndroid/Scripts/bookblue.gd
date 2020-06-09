extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")

func _on_book_body_entered(body):
	if "Player" in body.name:
		body.book_power_up2()
		queue_free()
