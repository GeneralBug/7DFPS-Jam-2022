extends KinematicBody
# Defines player controls and movement
# Based on tutorial by DillonDev: https://www.youtube.com/watch?v=8-198msNlGg

export var Mouse_Sensitivity: float = 0.2
export var Movement_Speed: float = 3
onready var Camera_Anchor = $"Camera Anchor"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		#rotate horizontal
		rotate_y(deg2rad(event.relative.x * -1 * Mouse_Sensitivity))
		#rotate vertical
		Camera_Anchor.rotate_x(deg2rad(event.relative.y * Mouse_Sensitivity))
		Camera_Anchor.rotation.x = clamp(Camera_Anchor.rotation.x, PI/-2, PI/2)
	
func _physics_process(delta):
	move_and_slide(get_input_direction() * Movement_Speed, Vector3.UP)
	
func get_input_direction() -> Vector3:
	#gets forward/backward movement
	var z = (Input.get_action_strength("player_forward") - Input.get_action_strength("player_backward"))
	#gets strafe movement
	var x = (Input.get_action_strength("player_left") - Input.get_action_strength("player_right"))

	return transform.basis.xform(Vector3(x, 0, z).normalized())
