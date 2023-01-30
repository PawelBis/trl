extends Node

export(Array, Resource) var map_chunks
export(Vector2) var starting_coord

# we have to figure out better system for pairing tiles with colors
var stone_wall_color : Color = Color(1,0,0,1)

func _ready():
	
	if map_chunks.size() > 0:
		
		for map_chunk in map_chunks:
			var chunk : MapChunkResource = map_chunk
			var image : Image = chunk.map_chunk.get_data()
			var tileSet : TileSet = chunk.tile_set
			
			
			image.lock()
			var grid = []
			var grid_width = image.get_size().x
			var grid_height = image.get_size().y
			
			
			for i in grid_width:
				grid.push_back([])
				for j in grid_height:
					
					if stone_wall_color == image.get_pixel(i,j):
						MapVariables.grid.set_cell(starting_coord.x + i, starting_coord.y + j,4)
					
					grid[i].push_back(0)
					
			image.unlock()
			
			MapVariables.grid.update_bitmask_region(starting_coord, image.get_size())
			starting_coord.x += image.get_size().x
			
	# temporary solution for updating NavigationGrid	
	MapVariables.grid._ready()
