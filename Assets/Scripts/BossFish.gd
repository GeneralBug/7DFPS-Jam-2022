extends KinematicBody

enum STATE {ATTACK, PATROL, FLEE}
var State = STATE.PATROL
var Patrol_Points = [$"Patrol_1", $"Patrol_2", $"Patrol_3", $"Patrol_4"]
onready var Nav_Agent = $NavigationAgent
onready var Player = $"../../Player"
var Target_Point: int = 0
export var Speed: float = 1
var Changing_State: bool = true

func _ready():
	pass # Replace with function body.

#TODO: fish AI, shooting
# THREE states:
#	patrol - swim between a set of points
#	attack - charge at the player
#	run away - charge away from the player

func _physics_process(delta):
	match State:
		STATE.PATROL:
			if(Changing_State):
				
				Changing_State = false
			#move toward next patrol point
			#if at patrol point, iterate index
			if(Nav_Agent.is_navigation_finished()):
				Target_Point += 1
				if(Target_Point >= Patrol_Points.size()):
					Target_Point = 0
			
			var direction = self.global_transform.origin.direction_to(Patrol_Points[Target_Point].global_transform.origin)
			
			move_and_slide(direction * Nav_Agent.max_speed, Vector3.UP, Patrol_Points[Target_Point].global_transform.origin)
			pass
		STATE.ATTACK:
			if(Changing_State):
				
				Changing_State = false
			#move towards player
			pass
		STATE.FLEE:
			if(Changing_State):
				
				Changing_State = false
			#move away from player
			#when a given distance from player, return to patrolling
			pass

func Calc_Vector(target: Vector3) -> Vector3:
	var new_vector = Vector3(target.x - self.translation.x, target.y - self.translation.y, target.z - self.translation.z).normalized()
	##print(new_vector)
	return new_vector

func Detected():
	if(State == STATE.PATROL):
		Changing_State = true
		State == STATE.ATTACk
		

