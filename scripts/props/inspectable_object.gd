class_name InspectableObject
extends Interactable

@export_multiline var narration_text: String = "The kettle is warm. But there's no one here."
@export var inspect_duration: float = 4.0

signal inspected_text(text: String, duration: float)

func _ready() -> void:
	if prompt_message == "Inspect" and narration_text.length() > 0:
		prompt_message = "Examine"

func _on_interacted(_player: Node3D) -> void:
	inspected_text.emit(narration_text, inspect_duration)
	if GameManager:
		GameManager.show_subtitle(narration_text, inspect_duration)
