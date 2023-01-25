extends Node

var baseMoveSpeed = 150
var currentMoveSpeed = baseMoveSpeed

var timeUnitsPool = 0

#var for testing right now
var isPlayerInMeleeRange = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_command_executed(cost):
	#
	if isPlayerInMeleeRange:
		_attack_Player(cost)
	else:
		_move_towards_Player(cost)

func _move_towards_Player(cost):
	print("moving towards player")
	
func _attack_Player(cost):
	print("attacking player")
