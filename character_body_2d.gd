extends CharacterBody2D

#oh shoot its dash time
const DASH_SPEED = 900
const DASH_TIME = 0.15
const DASH_COOLDOWN = 0.5
var is_dashing = false
var can_dash = true
var dash_dir = 1.0
var facing =1.0

@onready var sprite = $Sprite2D
@onready var base_scale = sprite.scale   # (0.156, 0.234)


var speed = 300
const jump_velocity= -400.0
var is_smashing = false
var cyote = 0
func cyote_frame() -> void:
	if is_on_floor():
		cyote = 25
	if not is_on_floor():
		cyote-=1
		await get_tree().create_timer(0.01).timeout



func _physics_process(delta: float) -> void:
	# Add the gravity.
	cyote_frame()
	$var_lable.text = str(cyote)
	if not is_on_floor():
		velocity += get_gravity() * delta

#sprinting time
	speed = 500 if Input.is_action_pressed("Sprint") else 300

	if Input.is_action_just_pressed("Dash") and can_dash and not is_dashing:
		start_dash()

	if is_dashing:
		velocity.x = dash_dir * DASH_SPEED
		velocity.y = 0
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_pressed("Jump") and (is_on_floor() or cyote > 0):
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()


func start_dash() -> void:
	is_dashing = true
	can_dash = false
	
# Dash the way you're holding or the way you're facing
	var input_dir := Input.get_axis("Left", "Right")
	dash_dir = input_dir if input_dir != 0 else facing

	sprite.rotation_degrees = 90 * dash_dir
	sprite.scale = base_scale * Vector2(1.3, 0.7)

	await get_tree().create_timer(DASH_TIME).timeout
	end_dash()


func end_dash() -> void:
	is_dashing = false
	sprite.rotation_degrees = 0
	sprite.scale = base_scale

	await get_tree().create_timer(DASH_COOLDOWN).timeout
	can_dash = true
