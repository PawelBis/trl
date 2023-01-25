extends Node

var baseMoveSpeed = 100
var currentMoveSpeed = baseMoveSpeed

var maxHealth = 100
var currentHealth = maxHealth

signal command_executed(cost)

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
		5
	if diagonal:
		$Sprite.position.x = $Sprite.position.x + x
		$Sprite.position.y = $Sprite.position.y + y
		1
	emit_signal("command_executed", currentMoveSpeed)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
