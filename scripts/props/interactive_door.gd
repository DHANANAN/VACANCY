class_name InteractiveDoor
extends Interactable

@export var open_angle: float = 85.0
@export var open_speed: float = 3.0
@export var is_open: bool = false
@export var door_hinge_path: NodePath

var hinge_node: Node3D
var target_rotation_y: float = 0.0

func _ready() -> void:
	prompt_message = "Open Door"
	if not door_hinge_path.is_empty():
		hinge_node = get_node(door_hinge_path)
	else:
		hinge_node = self

func _process(delta: float) -> void:
	if hinge_node:
		hinge_node.rotation.y = lerp_angle(hinge_node.rotation.y, target_rotation_y, delta * open_speed)

func _on_interacted(_player: Node3D) -> void:
	is_open = !is_open
	if is_open:
		target_rotation_y = deg_to_rad(open_angle)
		prompt_message = "Close Door"
	else:
		target_rotation_y = 0.0
		prompt_message = "Open Door"

