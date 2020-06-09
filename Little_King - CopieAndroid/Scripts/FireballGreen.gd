extends Area2D

const SPEED = 140
var velocity = Vector2()
var direction = 1

func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity) 
	$AnimatedSprite.play("shoot")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_FireballPowered_body_entered(body):
	if "Enemy" in body.name:
		if body.scale >= Vector2(3,3):
			body.damage(40)
		if body.scale >= Vector2(2,2):
			body.damage(60)
		if body.scale > Vector2(1,1):
			body.damage(80)
		if body.scale <= Vector2(1,1):
			body.damage(100)
	elif "Snake" in body.name:
		if body.scale >= Vector2(3,3):
			body.damage(15)
		if body.scale >= Vector2(2,2):
			body.damage(18)
		if body.scale > Vector2(1,1):
			body.damage(20)
		if body.scale <= Vector2(1,1):
			body.damage(25)
	queue_free()
