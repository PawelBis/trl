extends TileMap
class_name NavigationGrid

# Navigation is Astar based. Each AStart point is indexed based on
# the position of the cell in the tileset. We store WORLD positions
# of the points, not grid positions. This way we can use paths returned by the 
# astar directly.
var astar = AStar2D.new()
var grid_rect
export(bool) var debug_navigation


# Returns -1 if given tilemap_position is out of the grid
func calculate_astar_id(tilemap_position):
	if !grid_rect.has_point(tilemap_position):
		return -1
	return tilemap_position.x + tilemap_position.y * grid_rect.size.x


func cell_to_world(map_position):
	var world_position = map_to_world(map_position) + (cell_size / 2)
	return to_global(world_position)


func world_to_cell(world_position):
	return world_to_map(to_local(world_position))


func get_path_between_points(from_position, to_position):
	var from_id = calculate_astar_id(world_to_cell(from_position))
	var to_id = calculate_astar_id(world_to_cell(to_position))
	if from_id == -1 || to_id == -1:
		return null
	return astar.get_point_path(from_id, to_id)


# Check if cell is occupied. For now an occupied cell is a cell where at least
# one collider can be found
func is_cell_occupied(map_position):
	var world_position = cell_to_world(map_position)
	return !get_world_2d().get_direct_space_state().intersect_point(world_position).empty()


func try_create_astar_connections(map_position):
	var target_astar_id = calculate_astar_id(map_position)
	if target_astar_id == -1:
		return
	# We should connect this cell only if it is not occupied
	if !is_cell_occupied(map_position):
		var bidirectional = true
		var neighbour_cells = [Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1), Vector2(-1, 0)]
		for neighbour in neighbour_cells:
			var id = calculate_astar_id(map_position + neighbour)
			if id != -1 && !is_cell_occupied(map_position + neighbour):
				astar.connect_points(target_astar_id, id, bidirectional)


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
			astar.add_point(astar_id, cell_to_world(map_position))
			try_create_astar_connections(map_position)
	self.update()



# This is called whenever scene root node spawns a new child. We use this to track
# and register new navigation agents
func on_new_node_spawned(new_node):
	for child in new_node.get_children():
		if child is AiAgent:
			child.register_to_navigation(self)
			var cell = world_to_cell(new_node.global_position)
			new_node.global_position = cell_to_world(cell)


func _draw():
	if !debug_navigation:
		return
	for astar_cell in astar.get_points():
		var point_position = astar.get_point_position(astar_cell)
		draw_circle(point_position, 2.0, Color.lime)
		for connection in astar.get_point_connections(astar_cell):
			var target_position = astar.get_point_position(connection)
			draw_line(point_position, target_position, Color.red)


