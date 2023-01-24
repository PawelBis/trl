extends Node

var baseMoveSpeed = 100
var currentMoveSpeed = baseMoveSpeed
onready var turnSystem = $"../../TurnSystem"
onready var turnCounter = $"../../TurnSystem/TurnCounter"



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	if Input.is_action_just_pressed("Up"):
		_tryToMove(0, -16, false)
	if Input.is_action_just_pressed("Down"):
		_tryToMove(0, 16, false)
	if Input.is_action_just_pressed("Left"):
		_tryToMove(-16, 0, false)
	if Input.is_action_just_pressed("Right"):
		_tryToMove(16, 0, false)
	if Input.is_action_just_pressed("UpLeft"):
		_tryToMove(-16, -16, true)
	if Input.is_action_just_pressed("DownLeft"):
		_tryToMove(-16, +16, true)
	if Input.is_action_just_pressed("UpRight"):
		_tryToMove(16, -16, true)
	if Input.is_action_just_pressed("DownRight"):
		_tryToMove(16, 16, true)
		
func _physics_process(_delta):
	get_input()
	
func _tryToMove(x, y, diagonal):
	if !diagonal:
		$Sprite.position.x = $Sprite.position.x + x
		$Sprite.position.y = $Sprite.position.y + y
		turnCounter._advanceTime(currentMoveSpeed)
		
		
	if diagonal:
		$Sprite.position.x = $Sprite.position.x + x
		$Sprite.position.y = $Sprite.position.y + y
		turnCounter._advanceTime(currentMoveSpeed * turnSystem.diagonalMovementCost)
		
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
