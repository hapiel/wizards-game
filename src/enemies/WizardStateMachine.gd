
class_name WizardStateMachine
extends Node

enum State_enum {IDLE, ATTACKING, STUNNED, FROZEN}

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Emitt on update
signal state_process(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export(State_enum) var initial_state

# The current active state. At the start of the game, we get the `initial_state`.
onready var current_state: int = initial_state

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _process(delta):
	emit_signal("state_process", current_state)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state: int, msg: Dictionary = {}) -> void:
	current_state = target_state
	emit_signal("transitioned", target_state)
