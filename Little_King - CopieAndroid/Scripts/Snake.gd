extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export(int) var speed = 30
export(int) var max_health = 100
export(Vector2) var  size = Vector2(1, 1)
var velocity = Vector2()
var direction = 1
var is_dead = false
var scorekill = 0
var nrs = 0

signal AddScore(scorekill)
signal max_health(max_health)
signal healt_updated(health)
signal killed()
signal numbers(nrs)

onready var health = max_health setget _set_health
onready var invulnerabillity_timer = $InvulnerabillityTimer
onready var damage_anim = $AnimationPlayer

func _ready():
	scale = size
	pass

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
			
		$AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.damage(50)

func _on_Timer_timeout():
	queue_free()
	
func damage(amount):
	if invulnerabillity_timer.is_stopped():
		invulnerabillity_timer.start()
		_set_health(health - amount)
		damage_anim.play("damage")
		damage_anim.queue("flash")

func kill():
	scorekill += 1
	nrs += 1
	emit_signal("AddScore", scorekill)
	emit_signal("numbers", nrs)
	is_dead = true
	velocity = Vector2(0, 0)
	$Killed.play()
	$AnimatedSprite.play("dead")
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()
	if scale > Vector2(1, 1):
		get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("healt_updated", health)
		if(health == 0):
			kill()

func _on_InvulnerabillityTimer_timeout():
	damage_anim.play("rest")
