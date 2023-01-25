# AiAgent is a node responsible for Ai resource management and decision making.
extends Node
class_name AiAgent

export(NodePath) var target
var registered = false
var commands: Array
var ready_commands: Array
var navigation_grid
var focus_target

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node(target):
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# For now just execute first command, for tests
	if !ready_commands.empty(): 
		ready_commands[0].execute_command()


func on_command_executed(command):
	print("I should consume some time units here!")


func on_command_off_cooldown(command):
	ready_commands.push_back(command)


func on_command_on_cooldown(command):
	ready_commands.erase(command)
