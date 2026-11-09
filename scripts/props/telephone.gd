class_name Telephone
extends Interactable

## Story Beat: The phone rings. Dev is calling from the outside world.
## The line is silent/dead when answered because the real call is happening in another place.

@export var is_ringing: bool = false
@export var caller_id: String = "Incoming Call: Dev"

func _ready() -> void:
	prompt_message = "Answer Call"

func start_ringing() -> void:
	is_ringing = true
	prompt_message = "Answer Call (" + caller_id + ")"

func stop_ringing() -> void:
	is_ringing = false
	prompt_message = "Examine Phone"

func _on_interacted(_player: Node3D) -> void:
	if is_ringing:
		is_ringing = false
		if GameManager:
			GameManager.has_answered_phone = true
			GameManager.show_subtitle("Silence. A dead line. But someone was breathing on the other end.", 4.5)
	else:
		if GameManager:
			GameManager.show_subtitle("Battery: 4%. 18 missed calls from Dev.", 3.5)
