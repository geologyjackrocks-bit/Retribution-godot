extends CharacterBody2D


var speed = 300.0
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

	if Input.is_action_pressed("Sprint"):
		speed = 500
	else:
		speed = 300
	# Handle jump.
	if Input.is_action_pressed("Jump") and (is_on_floor() or !cyote<0):
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
