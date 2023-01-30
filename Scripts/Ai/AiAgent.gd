# AiAgent is a node responsible for Ai resource management and decision making.
extends Node
class_name AiAgent

export(NodePath) var target
var registered = false
var commands: Array
var ready_commands: Array
var navigation_grid
var focus_target


var timeUnitsPool = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = PlayerVariables.player
	player.connect("command_executed", self, "on_player_command_executed")
	
	
	if target && has_node(target):
		focus_target = get_node(target)
	for child in get_children():
		if child is Command:
			commands.push_back(child)
			ready_commands.push_back(child)
			child.connect("command_executed", self, "on_command_executed")
			child.connect("command_on_cooldown", self, "on_command_on_cooldown")
			child.connect("command_off_cooldown", self, "on_command_off_cooldown")
			child.body = get_parent()
			child.navigation = navigation_grid
			child.target = focus_target


func register_to_navigation(new_navigation_grid):
	navigation_grid = new_navigation_grid
	registered = true

func on_command_executed(command):
	print("I should consume some time units here!")


func on_command_off_cooldown(command):
	ready_commands.push_back(command)


func on_command_on_cooldown(command):
	ready_commands.erase(command)


func on_player_command_executed(cost):
	timeUnitsPool += cost
	
	var actions_exhausted = false
	
	while !actions_exhausted:
		var hi_score = 0
		var hi_score_command = null
		var path = []
		if focus_target:
			path = navigation_grid.get_path_between_points(get_parent().global_position, focus_target.global_position)
		for command in ready_commands:
			var command_score = command.calculate_score(timeUnitsPool, path)
			if command_score > hi_score:
				hi_score = command_score
				hi_score_command = command
				
		if hi_score_command:
			timeUnitsPool = timeUnitsPool - hi_score_command.cost
			hi_score_command.execute(path)		
			print("pool: " + str(timeUnitsPool))
		else:
			actions_exhausted = true
	
	
