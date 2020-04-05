extends KinematicBody2D

var movement = Vector2();
var on_ground
var k = null
var j = null
var i = null
var is_dead = false
var is_attacking = false
var fireball_power = 1
var too_high = false
export (int) var MaxHpPlayer = 100

signal HpPlayerUpdated(health)

onready var health = MaxHpPlayer

const moveSpeed = 70
const gravity = 10
const jump_force = -250
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Scenes/Fireball.tscn")
const FIREBALEPOWERED = preload("res://Scenes/FireballPowered.tscn")
const FIREBALEBLUE = preload("res://Scenes/FireballBlue.tscn")
const FIREBALEGREEN = preload("res://Scenes/FireballGreen.tscn")

func _ready():
	pass

func _physics_process(delta):
	if is_dead == false:
		if Input.is_action_pressed("moveRight"):
			if is_attacking == false:
				j = true
				movement.x = moveSpeed
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = false
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
				if Input.is_action_pressed("sprint") && j == true:
					movement.x = moveSpeed * 2
					$AnimatedSprite.play("run")
					$AnimatedSprite.flip_h = false
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
		elif Input.is_action_pressed("moveLeft"):
			if is_attacking == false:
				j = true
				movement.x = -moveSpeed
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = true
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
				if Input.is_action_pressed("sprint") && j == true:
					movement.x = -moveSpeed * 2
					$AnimatedSprite.play("run")
					$AnimatedSprite.flip_h = true
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			j = false
			movement.x = 0
			if on_ground == true && is_attacking == false:
				$AnimatedSprite.play("Idle")
			
		if Input.is_action_just_pressed("jump"):
			if is_attacking == false:
				if on_ground == true:
					movement.y = jump_force
					on_ground = false
					k = true
				
			
		if Input.is_action_just_pressed("shoot") && is_attacking == false:
			is_attacking = true
			var fireball = null
			$AnimatedSprite.play("attack")
			if fireball_power == 1:
				fireball = FIREBALL.instance()
			elif fireball_power == 2:
				fireball = FIREBALEPOWERED.instance()
			elif fireball_power == 3:
				fireball = FIREBALEBLUE.instance()
			elif fireball_power == 4:
				fireball = FIREBALEGREEN.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		elif Input.is_action_just_released("shoot"): 
			is_attacking = false
		
		movement.y += gravity
		if movement.y > 20:
			print(movement.y)
			
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			if is_attacking == false:
				if Input.is_action_just_pressed("jump") && k == true:
					movement.y = jump_force
					k = false
					if movement.y < 0:
						$AnimatedSprite.play("jump")
					else:
						$AnimatedSprite.play("fall")
				if movement.y < 0:
					$AnimatedSprite.play("jump")
				else:
					$AnimatedSprite.play("fall") 
				
		if movement.y > 350:
			too_high = true
		if too_high == true and $RayCast2D.is_colliding() == true:
			dead1(25)
			too_high = false
		
		movement = move_and_slide(movement, FLOOR)
		
		if get_slide_count():
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead1(25)

func dead1(damage):
	health -= damage
	emit_signal("HpPlayerUpdated", health)
	#print(health)
	if health <= 0:
		is_dead = true
		movement = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.set_deferred("disabled", true)
		$Timer.start()
	

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func book_power_up():
	fireball_power = 2

func book_power_up2():
	fireball_power = 3

func book_power_up3():
	fireball_power = 4
