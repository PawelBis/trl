extends Resource
class_name MapChunkResource

export(TileSet) var tile_set
export(Texture) var map_chunk

#var map_chunk_image: Image
#var map_chunk_image: Image = map_chunk.get_data()

#var grid = []
#var grid_width = map_chunk_image.get_size().x
#var grid_height = map_chunk_image.get_size().y
#
#func _ready():
#	for i in grid_width:
#		grid.append([])
#		for j in grid_height:
#			grid[i].append(0)

#func _init():
#	if map_chunk:
#		var map_chunk_image: Image = map_chunk.get_data()
#		print("Dupa")
