extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var attack_damage = 1
@export var attack_area: Area2D

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _input(event: InputEvent) -> void:
	# Handle jump
	if event.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	# Handle jump down
	if event.is_action_pressed("MoveDown"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)
	# Handle left click mouse
	if event.is_action_pressed("MouseLeftClick"):
		attack()

func attack() -> void:
	var bodies = attack_area.get_overlapping_bodies()
	
	print("trying to attack!")
	for body in bodies:
		print("trying to attack2!")
		if body.has_method("take_damage"):
			print("taking damage!")
			body.take_damage(attack_damage)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:           
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()
