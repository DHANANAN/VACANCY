class_name Player
extends CharacterBody3D

## VACANCY: First-person controller with the Cervical Collar mechanic (Right-Turn Lock)

@export_group("Movement")
@export var walk_speed: float = 2.4
@export var sprint_speed: float = 3.8
@export var acceleration: float = 8.0
@export var friction: float = 10.0
@export var mouse_sensitivity: float = 0.002

@export_group("Cervical Collar / Head Lock")
## If enabled, player's horizontal look to the right is restricted (the hospital collar)
@export var collar_restriction_active: bool = true
## Max degrees the player can turn head right relative to body/forward (default 38-40 degrees)
@export var max_right_angle_degrees: float = 38.0
## Max degrees the player can turn head left (broad range, e.g. 85 degrees)
@export var max_left_angle_degrees: float = 85.0
@export var min_pitch_degrees: float = -75.0
@export var max_pitch_degrees: float = 75.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interaction_ray: RayCast3D = $Head/Camera3D/InteractionRay

var current_head_yaw: float = 0.0
var current_head_pitch: float = 0.0
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		_handle_mouse_look(event.relative)
	
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _handle_mouse_look(relative: Vector2) -> void:
	# Pitch (looking up/down)
	current_head_pitch -= relative.y * mouse_sensitivity
	current_head_pitch = clamp(current_head_pitch, deg_to_rad(min_pitch_degrees), deg_to_rad(max_pitch_degrees))
	camera.rotation.x = current_head_pitch

	# Yaw (looking left/right)
	var yaw_delta = -relative.x * mouse_sensitivity
	
	if collar_restriction_active:
		# Collar mode: Head turns independently within collar boundaries
		# Negative yaw is turning right, positive yaw is turning left
		var target_yaw = current_head_yaw + yaw_delta
		var min_yaw = -deg_to_rad(max_right_angle_degrees) # Restricted right
		var max_yaw = deg_to_rad(max_left_angle_degrees)   # Free left
		
		current_head_yaw = clamp(target_yaw, min_yaw, max_yaw)
		head.rotation.y = current_head_yaw
		
		# If user keeps pushing left/right, slowly rotate the whole body so they can steer,
		# but the head always remains stiffened relative to forward alignment!
		if target_yaw < min_yaw or target_yaw > max_yaw:
			rotate_y(yaw_delta * 0.4)
	else:
		# Free rotation (end of game when collar is removed)
		rotate_y(yaw_delta)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Movement inputs
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var move_direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_speed = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
	var target_vel = move_direction * target_speed
	
	if move_direction.length_squared() > 0.01:
		velocity.x = move_toward(velocity.x, target_vel.x, acceleration * delta)
		velocity.z = move_toward(velocity.z, target_vel.z, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
		velocity.z = move_toward(velocity.z, 0.0, friction * delta)

	move_and_slide()

