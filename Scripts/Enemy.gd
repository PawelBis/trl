extends Node

var baseMoveSpeed = 150
var currentMoveSpeed = baseMoveSpeed
var attackSpeed = 50

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
	#try to attack the player if they are in melee range, move toward them if else
	if isPlayerInMeleeRange:
		_try_to_attack_Player(cost)
	else:
		_move_towards_Player(cost)

func _move_towards_Player(cost):
	print("moving towards player")
	
func _try_to_attack_Player(cost):
	if cost + timeUnitsPool >= attackSpeed:
		print("attacking player")
		timeUnitsPool = (timeUnitsPool + cost) - attackSpeed
		print("pool: " + str(timeUnitsPool))
	else:
		timeUnitsPool += cost
		print("storing time units in pool")
