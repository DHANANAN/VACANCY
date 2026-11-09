class_name DrippingTap
extends Node3D

## Story Clue #2: The kitchen drip that matches a heart monitor rhythm.

@export var drip_sound_stream: AudioStream
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready() -> void:
	if not audio_player:
		audio_player = AudioStreamPlayer3D.new()
		audio_player.name = "AudioStreamPlayer3D"
		audio_player.unit_size = 5.0
		audio_player.max_distance = 15.0
		add_child(audio_player)
	
	if AudioConductor:
		AudioConductor.beat_triggered.connect(_on_beat)

func _on_beat() -> void:
	if audio_player and audio_player.stream:
		audio_player.pitch_scale = randf_range(0.96, 1.04)
		audio_player.play()

