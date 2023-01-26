extends Command
class_name MoveCommand

# For now we set cost and cooldown to custom values for tests. In game the coldown should be 0
func _ready():
	cost = 0
	cooldown = 1

func execute(path_to_target: Array):
	print("Moving")
	if !target || !navigation:
		return
	body.global_position = path_to_target[1]
	emit_signal("command_on_cooldown", self)
	yield(get_tree().create_timer(cooldown), "timeout")
	emit_signal("command_off_cooldown", self)


# Ultimately this score should be curve based
func calculate_score(path_to_target: Array) -> float:
    if path_to_target.size() > 2:
        return 0.5
    else:
        return 0.0
