extends Command
class_name MoveCommand

# For now we set cost and cooldown to custom values for tests. In game the coldown should be 0
func _ready():
	cost = 0
	cooldown = 1

func execute_command():
	if !target || !navigation:
		return
	var path_to_target: Array = navigation.get_path_between_points(body.global_position, target.global_position)
	if path_to_target.size() > 2:
		body.global_position = path_to_target[1]
	emit_signal("command_on_cooldown", self)
	print("Move executed")
	yield(get_tree().create_timer(cooldown), "timeout")
	emit_signal("command_off_cooldown", self)
