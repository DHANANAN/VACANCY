extends Node

## VACANCY: Audio Conductor
## Autoload: AudioConductor
## Synchronizes procedural heartbeat/drip timing, breathing, and silence mechanics

var drip_timer: Timer
var current_bpm: float = 72.0
var drip_interval: float = 60.0 / 72.0

signal beat_triggered()

func _ready() -> void:
	drip_timer = Timer.new()
	drip_timer.one_shot = false
	drip_timer.wait_time = drip_interval
	drip_timer.timeout.connect(_on_drip_timeout)
	add_child(drip_timer)
	drip_timer.start()

	if GameManager:
		GameManager.heart_rate_changed.connect(_on_heart_rate_changed)

func _on_heart_rate_changed(new_bpm: float) -> void:
	current_bpm = new_bpm
	drip_interval = 60.0 / max(new_bpm, 30.0)
	drip_timer.wait_time = drip_interval

func _on_drip_timeout() -> void:
	beat_triggered.emit()

