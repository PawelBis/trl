extends Node
class_name Command

export(int) var cost = 50
export(float) var cooldown = 0.0
export(Curve) var alpha_curve
var body
var navigation
var target

signal command_executed(command)
signal command_off_cooldown(command)
signal command_on_cooldown(command)

func execute(path_to_target: Array):
	pass


# This is used only by the AiAgents. For now we calculate this only for meelee agent, so just check if distance_to_player is greater than 0
func calculate_score(timeunitspool: int, path_to_target: Array) -> float:
	return 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
