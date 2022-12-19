extends KinematicBody

enum STATE {ATTACK, PATROL, FLEE}
var State = STATE.PATROL

export var Patrol_Agent_Path: NodePath
var Patrol_Agent 
onready var Player = $"../../Player"
var Target_Point: int = 0
export var Speed: float = 1
var Changing_State: bool = true


func _ready():
	get_node("../AnimationPlayer").play("swim")
	Patrol_Agent = get_node(Patrol_Agent_Path)

func _input(event):
	#release curour
	if Input.get_action_strength("ui_accept") > 0:
		print("fish pos:")
		print(global_translation)
		print("patrol pos:")
		print(Patrol_Agent.global_translation)

#TODO: fish AI, shooting
# THREE states:
#	patrol - swim between a set of points
#	attack - charge at the player
#	run away - charge away from the player

func _physics_process(_delta):
	match State:
		STATE.PATROL:
			if(Changing_State):
				print("patrolling")
				Changing_State = false
			#move toward next patrol point
			#if at patrol point, iterate index
			#if(Nav_Agent.is_navigation_finished()):
				
			#follow patrol agent

			look_at(Patrol_Agent.global_transform.origin, Vector3.UP)
			move_and_collide(Calc_Vector() * Speed)
			
			pass
		STATE.ATTACK:
			if(Changing_State):
				print("attacking")
				Changing_State = false
			#move towards player
			pass
		STATE.FLEE:
			if(Changing_State):
				print("fleeing")
				Changing_State = false
			#move away from player
			#when a given distance from player, return to patrolling
			pass

func Calc_Vector() -> Vector3:
	var new_vector = Vector3(Patrol_Agent.global_translation.x - self.global_translation.x, Patrol_Agent.global_translation.y - self.global_translation.y, Patrol_Agent.global_translation.z - self.global_translation.z).normalized()
	##print(new_vector)
	return new_vector

func Detected():
	if(State == STATE.PATROL):
		Changing_State = true
		State == STATE.ATTACk
		
func On_Velocity_Computed():
	pass

func _on_Timer_timeout():
	pass

func _on_Detection_Radius_body_entered(body):
	#TODO: check for player
	pass # Replace with function body.
