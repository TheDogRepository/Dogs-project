extends KinematicBody2D

const UP = Vector2(0, -1)
export (float, 0, 4) var speed_step_ground = 4.0
export (float, 0, 4) var speed_step_air = 0.8
export (int) var speed_max = 140
export (int) var jump_vel = -400
var velocity = Vector2()

func _physics_process(delta):
	var speed_step = 0
	if is_on_floor():
		speed_step = speed_step_ground
	else:
		speed_step = speed_step_air
		
	if Input.is_action_pressed('right'):
		velocity.x = velocity.x*(1-delta*speed_step) + speed_max*delta*speed_step
		$AnimatedSprite.play("sprint")
		$AnimatedSprite.flip_h = false
	
	if Input.is_action_pressed('left'):
		velocity.x = velocity.x*(1-delta*speed_step) - speed_max*delta*speed_step
		$AnimatedSprite.play("sprint")
		$AnimatedSprite.flip_h = true
	
	elif !Input.is_action_pressed('right') && is_on_floor():
		$AnimatedSprite.play("idle")
		velocity.x = lerp(velocity.x, 0, 0.2)
	
	if velocity.y < 500:
		velocity.y += 20
	if is_on_floor():
		velocity.y = 5
		if Input.is_action_pressed("up"):
			velocity.y = jump_vel
	move_and_slide(velocity, UP)
