extends Command
class_name MeleeCommand

export(Texture) var animation
export(int) var attack_range = 1
export(float) var attack_time = 0.25

func execute(path_to_target: Array):
	var weapon_sprite = Sprite.new()
	var rotation = body.get_angle_to(path_to_target.pop_back())
	weapon_sprite.rotation = rotation + 45.0
	weapon_sprite.texture = animation
	weapon_sprite.z_index = 1
	body.add_child(weapon_sprite)
	#emit_signal("command_on_cooldown", self)
	yield(get_tree().create_timer(attack_time), "timeout")
	weapon_sprite.queue_free()
	yield(get_tree().create_timer(cooldown), "timeout")
	#emit_signal("command_off_cooldown", self)


# Ultimately this score should be curve based
func calculate_score(timeunitspool: int, path_to_target: Array) -> float:
	if timeunitspool - cost < 0:
		return 0.0
	if path_to_target.size() < 2 + attack_range:
		return 1.0
	else:
		return 0.0
