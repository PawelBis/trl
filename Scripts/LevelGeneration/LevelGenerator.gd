extends Node

export(Resource) var map_chunks
export(Vector2) var starting_coord

# we have to figure out better system for pairing tiles with colors
var stone_wall_color : Color = Color(1,0,0,1)


func _ready():
	if map_chunks:
		
		var chunk : MapChunkResource = map_chunks
		var image : Image = map_chunks.map_chunk.get_data()
		var tileSet : TileSet = map_chunks.tile_set
		
		
		image.lock()
		var grid = []
		var grid_width = image.get_size().x
		var grid_height = image.get_size().y
		
		
		for i in grid_width:
			grid.push_back([])
			for j in grid_height:
				
				if stone_wall_color == image.get_pixel(i,j):
					MapVariables.grid.set_cell(i,j,4)
				
				grid[i].push_back(0)
				
		image.unlock()
		
		MapVariables.grid.update_bitmask_region(starting_coord, image.get_size())
		
		# temporary solution for updating NavigationGrid
		MapVariables.grid._ready()


		
