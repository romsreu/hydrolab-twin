@tool
extends MeshInstance3D

@export var width: int = 20
@export var depth: int = 20
@export var max_height: float = 3.0
@export var cell_size: float = 1.0
@export var regenerate: bool = false:
	set(v):
		generate_terrain()

func _notification(what):
	if what == NOTIFICATION_READY:
		generate_terrain()

func generate_terrain():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)

	var heights = []
	for z in range(depth + 1):
		var row = []
		for x in range(width + 1):
			row.append(randf() * max_height)
		heights.append(row)

	for z in range(depth):
		for x in range(width):
			var v00 = Vector3(x * cell_size,        heights[z][x],      z * cell_size)
			var v10 = Vector3((x+1) * cell_size,    heights[z][x+1],    z * cell_size)
			var v01 = Vector3(x * cell_size,        heights[z+1][x],    (z+1) * cell_size)
			var v11 = Vector3((x+1) * cell_size,    heights[z+1][x+1],  (z+1) * cell_size)

			st.add_vertex(v00)
			st.add_vertex(v10)
			st.add_vertex(v01)

			st.add_vertex(v10)
			st.add_vertex(v11)
			st.add_vertex(v01)

	st.generate_normals()
	mesh = st.commit()
