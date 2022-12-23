#Based on Turtle's particle rope shader: https://godotshaders.com/shader/particle-rope/
tool
extends Particles

export var Start_Path : NodePath
export var End_Path   : NodePath

var Start : Position3D
var End   : Position3D

func _ready():
	Start = get_node(Start_Path)
	End = get_node(End_Path)


func _physics_process(_delta : float) -> void:
	process_material.set_shader_param("amount", amount)
	process_material.set_shader_param("start", Start.global_transform.origin)
	process_material.set_shader_param("end", End.global_transform.origin)
