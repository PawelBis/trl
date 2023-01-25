extends TileMap

# Navigation is Astar based. Each AStart point is indexed based on
# the position of the cell in the tileset. AWe store MAP(grid) positions
# of the points, not a WORLD positions. 
var astar = AStar2D.new()
var texture = preload("res://icon.png")
var grid_rect

# Returns -1 if given tilemap_position is out of the grid
func calculate_astar_id(tilemap_position):
	if !grid_rect.has_point(tilemap_position):
		return -1
	return tilemap_position.x + tilemap_position.y * grid_rect.size.y


# Check if cell is occupied. For now an occupied cell is a cell where at least
# one collider can be found
func is_cell_occupied(map_position):
	var world_position = map_to_world(map_position) + (cell_size / 2)
	world_position = to_global(world_position)
	# For now check if there is any collision at the world location
	return !get_world_2d().get_direct_space_state().intersect_point(world_position).empty()


func try_create_astart_connections(map_position):
	var target_astar_id = calculate_astar_id(map_position)
	if target_astar_id == -1:
		return

	# We should connect this cell only if it is not occupied
	if !is_cell_occupied(map_position):
		var bidirectional = true
		var left_astar_id = calculate_astar_id(map_position - Vector2(-1, 0))
		var up_astar_id = calculate_astar_id(map_position - Vector2(0, -1))
		if left_astar_id != -1:
			astar.connect_points(target_astar_id, left_astar_id, bidirectional)
		if up_astar_id != -1:
			astar.connect_points(target_astar_id, up_astar_id, bidirectional)


# Called when the node enters the scene tree for the first time.
func _ready():
	fix_invalid_tiles()
	grid_rect = get_used_rect()
	var top_left = grid_rect.position
	var bottom_right = top_left + grid_rect.size
	for y in range(top_left.y, bottom_right.y):
		for x in range(top_left.x, bottom_right.x):
			var map_position = Vector2(x,y)
			var astar_id = calculate_astar_id(map_position)
			astar.add_point(astar_id, map_position)
			try_create_astart_connections(map_position)
