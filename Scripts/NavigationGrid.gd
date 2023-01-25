extends TileMap

var astar = AStar2D.new()
var texture = preload("res://icon.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = get_used_cells()
	var top_left = Vector2(100,100)
	var bottom_right = Vector2(-100,-100)
	for cell in cells:
		if cell.x < top_left.x:
			top_left.x = cell.x
		if cell.y < top_left.y:
			top_left.y = cell.y
		if cell.x > bottom_right.x:
			bottom_right.x = cell.x
		if cell.y > bottom_right.y:
			bottom_right.y = cell.y
			
	for x in range(top_left.x, bottom_right.x, 1):
		for y in range(top_left.y, bottom_right.y, 1):
			var map_position = Vector2(x,y)
			var world_position = map_to_world(map_position) + (cell_size / 2)
			world_position = to_global(world_position)
			if get_world_2d().get_direct_space_state().intersect_point(world_position):
				# Add/Remove conntections from the AStart based on that
				pass
