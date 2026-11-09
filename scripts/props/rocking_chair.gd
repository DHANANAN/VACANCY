class_name RockingChair
extends Interactable

## Story Beat: Grandmother's chair. The one person who never muted him.

@export var rock_speed: float = 1.0
@export var rock_angle: float = 6.0
@export var is_rocking: bool = true

@onready var seat_pivot: Node3D = $SeatPivot
var time_passed: float = 0.0

func _ready() -> void:
	prompt_message = "Examine Chair"

func _process(delta: float) -> void:
	if is_rocking and seat_pivot:
		time_passed += delta * rock_speed
		seat_pivot.rotation.x = sin(time_passed) * deg_to_rad(rock_angle)

func _on_interacted(_player: Node3D) -> void:
	if GameManager:
		GameManager.show_subtitle("Grandmother's chair. It smells faintly of lavender and tea, as if she just stood up.", 4.5)
