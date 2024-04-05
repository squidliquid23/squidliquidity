extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anim.play("Jump")
		
	# Get the input direction and handle the movement/deceleration.
	var dir = Input.get_axis("Left", "Right")
	#print(dir)
	# Flips the AnimatedSprite2D based on the input direction
	if dir == 1:
		get_node("AnimatedSprite2D").flip_h = false
	elif dir == -1:
		get_node("AnimatedSprite2D").flip_h = true
	#IF any direction is pressed, the character will move that direction with variable "SPEED" (300)
	#in the case that you go left (negative direction), multiplying 'dir' by 'SPEED' will give a neg number! super cool!
	if dir:
		velocity.x = dir * SPEED
		if velocity.y == 0:
			anim.play("Run")
		elif not velocity.y == 0:
			anim.play("Jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 2)
		if velocity.y == 0:
			anim.play("Idle")
		elif not velocity.y == 0:
			anim.play("Fall")
	move_and_slide()	

# func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction == -1:
	#	get_node("AnimatedSprite2D").flip_h = true
	#elif direction == 1:
	#	get_node("AnimatedSprite2D").flip_h = false
	#if direction:
	#	velocity.x = direction * SPEED
	#	if velocity.y == 0:
	#		anim.play("Run")
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	#	if velocity.y == 0:
	#		anim.play("Idle")
	#move_and_slide()
