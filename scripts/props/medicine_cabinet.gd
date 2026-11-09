class_name MedicineCabinet
extends Interactable

## Story Rule #2 & Beat: The Bathroom Medicine Cabinet.
## Inside are Arin's relief tablets.

@export var is_open: bool = false
@onready var door_pivot: Node3D = $DoorPivot

func _ready() -> void:
	prompt_message = "Open Medicine Cabinet"

func _on_interacted(_player: Node3D) -> void:
	is_open = !is_open
	if door_pivot:
		var target_rot = deg_to_rad(85.0) if is_open else 0.0
		var tw = create_tween()
		tw.tween_property(door_pivot, "rotation:y", target_rot, 0.4)
	
	if is_open:
		prompt_message = "Take Tablet for Relief"
		if GameManager:
			GameManager.show_subtitle("Unlabeled amber bottles in the mirror. You reach for relief.", 3.5)
			GameManager.take_pill()
	else:
		prompt_message = "Open Medicine Cabinet"

