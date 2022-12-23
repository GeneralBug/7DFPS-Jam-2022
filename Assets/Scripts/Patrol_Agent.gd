extends KinematicBody

onready var Nav_Agent = $NavigationAgent
onready var Patrol_Points = [$"../Patrol_1", $"../Patrol_2", $"../Patrol_3", $"../Patrol_4"]
var Target_Point: int = 0
export var Speed_Factor: int = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Nav_Agent.connect("velocity_computed", self, "On_Velocity_Computed")

func _physics_process(_delta):
	var direction = self.global_transform.origin.direction_to(Nav_Agent.get_next_location())
	var _warn1 = move_and_slide(direction * (Nav_Agent.max_speed/Speed_Factor), Vector3.UP)

func _on_Patrol_1_body_entered(body):
	if(body == self):
		Target_Point = 1
		Nav_Agent.set_target_location(Patrol_Points[Target_Point].global_transform.origin)

func _on_Patrol_2_body_entered(body):
	if(body == self):
		Target_Point = 2
		Nav_Agent.set_target_location(Patrol_Points[Target_Point].global_transform.origin)

func _on_Patrol_3_body_entered(body):
	if(body == self):
		Target_Point = 3
		Nav_Agent.set_target_location(Patrol_Points[Target_Point].global_transform.origin)

func _on_Patrol_4_body_entered(body):
	if(body == self):
		Target_Point = 0
		Nav_Agent.set_target_location(Patrol_Points[Target_Point].global_transform.origin)
