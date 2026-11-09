extends Node

## VACANCY: Central Game Manager & Story State
## Autoload: GameManager (registered in project.godot)

enum Night {
	PROLOGUE,
	NIGHT_1,
	NIGHT_2,
	NIGHT_4, # Note: Order as planned in Story Bible (4 before 3)
	NIGHT_3,
	NIGHT_5,
	FAKE_CREDITS,
	NIGHT_6,
	NIGHT_7,
	HOSPITAL_ENDING
}

signal night_changed(new_night: Night)
signal subtitle_requested(text: String, duration: float)
signal episode_started(intensity: float)
signal episode_subsided()
signal heart_rate_changed(bpm: float)
signal phone_ringing_started()
signal phone_ringing_stopped()

# Story state
var current_night: Night = Night.PROLOGUE
var collar_active: bool = true
var base_heart_rate: float = 72.0
var current_heart_rate: float = 72.0
var pills_taken_count: int = 0
var dev_calls_missed: int = 0
var has_answered_phone: bool = false
var has_examined_kettle: bool = false
var letters_opened: Array[String] = []

# Perception / Visual distortion state
var episode_intensity: float = 0.0:
	set(val):
		episode_intensity = clamp(val, 0.0, 1.0)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func advance_night(next_night: Night) -> void:
	current_night = next_night
	night_changed.emit(current_night)
	print("[VACANCY] Transitioned to: ", Night.keys()[current_night])

func show_subtitle(text: String, duration: float = 3.5) -> void:
	subtitle_requested.emit(text, duration)

func trigger_episode(intensity: float = 0.6) -> void:
	episode_intensity = intensity
	current_heart_rate = 110.0
	heart_rate_changed.emit(current_heart_rate)
	episode_started.emit(intensity)

func take_pill() -> void:
	pills_taken_count += 1
	episode_intensity = 0.0
	current_heart_rate = base_heart_rate
	heart_rate_changed.emit(current_heart_rate)
	episode_subsided.emit()
	show_subtitle("Quiet. The screen steadies.", 3.0)

func trigger_phone_ring() -> void:
	phone_ringing_started.emit()

func stop_phone_ring() -> void:
	phone_ringing_stopped.emit()
