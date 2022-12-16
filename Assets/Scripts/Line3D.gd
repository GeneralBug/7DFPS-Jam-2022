extends Node2D
#from user "tproper": https://godotengine.org/qa/2762/draw-line-in-3d

class Line:

	var id
	var color
	var thickness
	var a = Vector2()
	var b = Vector2()
	var a_3D = Vector3()
	var b_3D = Vector3()
var Lines
var Camera_Node

func _ready():

	Camera_Node = get_viewport().get_camera()

	Lines = []
	set_process(true)

func _draw():

	for line in Lines:

		line.a = Camera_Node.unproject_position(line.a_3D)
		line.b = Camera_Node.unproject_position(line.b_3D)
		draw_line(line.a, line.b, line.color, line.thickness)

func _process(delta):

	update()

func Draw_Line3D(id, vector_a, vector_b, color, thickness):

	for line in Lines:
		if line.id == id:
			line.color = color
			line.a = Camera_Node.unproject_position(vector_a)
			line.b = Camera_Node.unproject_position(vector_b)
			line.a_3D = vector_a
			line.b_3D = vector_b
			line.thickness = thickness
			return

	var new_line = Line.new()
	new_line.id = id
	new_line.color = color
	new_line.a = Camera_Node.unproject_position(vector_a)
	new_line.b = Camera_Node.unproject_position(vector_b)
	new_line.a_3D = vector_a
	new_line.b_3D = vector_b
	
	new_line.thickness = thickness

	Lines.append(new_line)

func Remove_Line(id):

		var i = 0
		var found = false
		for line in Lines:

			if line.id == id:
				found = true
				break
			i += 1

		if found:

			Lines.remove(i)
