class_name PillBottle
extends Interactable

## Story Rule #2: The player chooses relief.
## Nothing forces the pills. The player reaches for them because the world is unbearable.

@export var prompt: String = "Take Tablet for Relief"

func _ready() -> void:
	prompt_message = prompt

func _on_interacted(_player: Node3D) -> void:
	if GameManager:
		GameManager.take_pill()

