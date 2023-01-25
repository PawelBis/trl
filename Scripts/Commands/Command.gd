extends Node
class_name Command

export(int) var cost = 50
export(float) var cooldown = 0
var body
var navigation
var target

signal command_executed(command)
signal command_off_cooldown(command)
signal command_on_cooldown(command)


func execute_command():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
