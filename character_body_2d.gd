extends CharacterBody2D

#oh shoot its dash time
const DASH_SPEED = 900
const DASH_TIME = 0.15
const DASH_COOLDOWN = 0.5
var is_dashing = false
var can_dash = true
var dash_dir = 1.0
var facing = 1.0
var soul = 500.0
var soul_use = false
var soul_max = 500.0
var direction = 0


@onready var sprite = $Sprite2D
@onready var base_scale = sprite.scale   # (0.156, 0.234)


var speed = 300
const jump_velocity= -400.0
var cyote = 0
func cyote_frame() -> void:
	if is_on_floor():
		cyote = 25
	if not is_on_floor():
		cyote-=1
		await get_tree().create_timer(0.01).timeout

func soul_bar() -> void:
	if soul_use and not soul < 0:
		soul -= 0.1
		await get_tree().create.timer(0.1).timeout
	if soul < 0 and not soul_use and soul < soul_max:
		soul += 0.1
		await get_tree().create_timer(0.007).timeout

func _physics_process(delta: float) -> void:
	# Add the gravity.
	cyote_frame()
	# $var_lable.text = str(soul)
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

#sprinting time
	speed = 500 if Input.is_action_pressed("Sprint") else 300

	if Input.is_action_pressed("Dash") and not soul < 0 and not is_on_floor():
		is_dashing = true
		velocity.y = 0
	else:
		is_dashing = false

	if is_dashing:
		soul_use = true
	else:
		soul_use = false

	# Handle jump.
	if Input.is_action_pressed("Jump") and (is_on_floor() or cyote > 0):
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
