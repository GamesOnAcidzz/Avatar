extends AnimationTree
class_name AnimationController

enum STATE {IDLE,DANCING,SPINNING,DANCINGSNOOP,DANCINGTWERK,DANCINGBREAKDANCE,ANGRY}

@onready var emote_state_machine:AnimationNodeStateMachinePlayback = get("parameters/MovementStateMachine/playback")

var state:STATE = STATE.IDLE
var is_emoting:bool = false

func _process(delta: float) -> void:
	if emote_state_machine.get_current_node() == "animations_Spinning":
		state = STATE.IDLE
	if emote_state_machine.get_current_node() != "MovementBlend" and !is_emoting:
		state = STATE.IDLE

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dancing"):
		state = STATE.DANCING
		is_emoting = !is_emoting
	if event.is_action_pressed("spinning"):
		state = STATE.SPINNING
		is_emoting = false
	if event.is_action_pressed("dancing_breakdance"):
		state = STATE.DANCINGBREAKDANCE
		is_emoting = false
	if event.is_action_pressed("dancing_twerk"):
		state = STATE.DANCINGTWERK
		is_emoting = false
	if event.is_action_pressed("dancing_snoop"):
		state = STATE.DANCINGSNOOP
		is_emoting = !is_emoting
	if event.is_action_pressed("angry"):
		state = STATE.ANGRY
		is_emoting = false





