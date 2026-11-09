class_name HospitalWristband
extends Interactable

## Story Clue #8 & Night 6 Reveal:
## A white plastic hospital wristband lying on the floor reading: ARIN.

func _ready() -> void:
	prompt_message = "Inspect Item on Floor"

func _on_interacted(_player: Node3D) -> void:
	if GameManager:
		GameManager.show_subtitle("A white hospital admission band: 'PATIENT: ARIN - ADMIT DATE: --/--/----'", 5.0)

