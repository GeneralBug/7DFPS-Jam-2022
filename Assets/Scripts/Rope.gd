#Based on Turtle's particle rope shader: https://godotshaders.com/shader/particle-rope/
tool
extends Particles

onready var Start : Position3D = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun/Start"
onready var End : Position3D = $"../Harpoon_Projectile/End"

func _ready():
	pass


func _physics_process(delta : float) -> void:
	process_material.set_shader_param("amount", amount)
	process_material.set_shader_param("start", Start.global_transform.origin)
	process_material.set_shader_param("end", End.global_transform.origin)
