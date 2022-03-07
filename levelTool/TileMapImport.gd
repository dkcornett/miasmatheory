extends TileMap

#export (Resource) var importMap
export (PackedScene) var mapScene
var tMap;

func _ready():
	get_tiles()

#youtube.com/watch?v=3NDMyA5379E for grabbing cells from packedscene
func get_tiles():
	if(mapScene.get("Tilemap")):
		tMap = mapScene.Tilemap
#		print("got tilemap")
#		tile_set = tMap.tile_set
#		var tiles = tMap.get_tiles_ids()
#		for tile in tiles:
#			tile_set.create_tile(tile)
		var cells = tMap.get_used_cells()
		for cell in cells:
			var index = tMap.get_cell(cell.x, cell.y)
			var importedTile = tMap.get_cell(index)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
