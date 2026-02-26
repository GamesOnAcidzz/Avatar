extends Node3D
class_name Scene

@onready var spectrum_analyzer:AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(1,2)
@onready var avatar:Avatar = get_node("Avatar")

# Add these variables to your class for smoother transitions
var smooth_magnitude: float = 0.0
@export var lerp_speed: float = 15.0  # Adjust for "snappiness" vs "smoothness"

func _process(delta: float) -> void:
	# 1. Get and normalize magnitude
	var raw_magnitude = spectrum_analyzer.get_magnitude_for_frequency_range(100, 1500).length()
	
	# 2. Smoothing (Interpolation) prevents the "flicker" effect
	smooth_magnitude = lerp(smooth_magnitude, raw_magnitude * 100, lerp_speed * delta)
	
	# 3. Threshold check
	if smooth_magnitude > 0.04:
		# Hide all mouths first
		for mouth in avatar.mouths.get_children():
			mouth.visible = false

		# Calculate indices and blend values
		# We use smooth_magnitude here instead of the raw value
		var index = clamp(round(lerp(0, 3, smooth_magnitude)), 0, 3)
		var blend_value = clamp(smooth_magnitude / 3.0, 0.0, 1.0)

		# 4. Apply Visibility
		var active_mouth = avatar.mouths.get_child(index)
		active_mouth.visible = true
		
		# 5. Apply Blends
		avatar.animation_controller.set("parameters/EyesBlend/blend_position", blend_value)
		avatar.animation_controller.set("parameters/MovementStateMachine/MovementBlend/blend_position", blend_value)
	else:
		# Optional: Reset to idle/closed mouth state when quiet
		_reset_to_idle()

func _reset_to_idle():
	# Logic to show the 'closed' mouth (likely index 0)
	pass
