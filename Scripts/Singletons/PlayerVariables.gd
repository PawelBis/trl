extends Node

onready var player = $"../Root/Player"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_path())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
