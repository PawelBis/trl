extends Node

var previousTurn = 0
var currentTurn = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _advanceTime(turnUnits):
	previousTurn = currentTurn
	currentTurn += turnUnits
	$CurrentTurnValueLabel.text = str(currentTurn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_command_executed(cost):
	_advanceTime(cost)
