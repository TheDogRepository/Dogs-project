extends KinematicBody2D

const UP = Vector2(0, -1)
export (int) var speed = 100
var velocity = Vector2()

func _physics_process(delta):
	if is_on_floor():
		velocity.x = 0
		if Input.is_action_pressed('right'):
			velocity.x += 1
			$AnimatedSprite.play("sprint")
			$AnimatedSprite.flip_h = false
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			$AnimatedSprite.play("sprint")
			$AnimatedSprite.flip_h = true
		elif !Input.is_action_pressed('right'):
			$AnimatedSprite.play("idle")
		velocity.x *= speed
	if velocity.y < 500:
		velocity.y += 20
	if is_on_floor():
		velocity.y = 5
		if Input.is_action_pressed("up"):
			velocity.y = -500
	move_and_slide(velocity, UP)
