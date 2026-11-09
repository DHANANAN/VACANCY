class_name ShadowFigure
extends CharacterBody3D

## VACANCY: The Figure (Future Arin)
## Story Rule #1: The figure is never malicious. It never attacks.
## Every 'threat' is a rescue attempt read wrongly.
## It stays in the player's peripheral right, matching breath, standing before cabinets/doors.

@export var player_target: Node3D
@export var stand_position: Vector3

@onready var head_pivot: Node3D = $HeadPivot

func _ready() -> void:
	# Story beat: The bent-neck tilted head
	if head_pivot:
		head_pivot.rotation_degrees.z = -18.0 # Tilted neck

func _physics_process(_delta: float) -> void:
	if player_target:
		# Always orient slightly towards player, but never rush or pursue aggressively
		var look_pos = player_target.global_position
		look_pos.y = global_position.y
		look_at(look_pos, Vector3.UP)
