extends KinematicBody

enum STATE {ATTACK, PATROL, FLEE}
var State = STATE.PATROL

export var Patrol_Agent_Path: NodePath
export var Flee_Path: NodePath
var Patrol_Agent 
var Flee_Pos
onready var Player = $"../../Player"
var Target_Point: int = 0
export var Speed: float = 1
var Changing_State: bool = true


func _ready():
	get_node("../AnimationPlayer").play("swim")
	Patrol_Agent = get_node(Patrol_Agent_Path)
	Flee_Pos = get_node(Flee_Path)

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
			#follow patrol agent
			look_at(Patrol_Agent.global_transform.origin, Vector3.UP)
			move_and_collide(Calc_Vector(Patrol_Agent.global_translation) * Speed)
			pass
			
		STATE.ATTACK:
			if(Changing_State):
				print("attacking")
				Changing_State = false
			#follow player
			look_at(Player.global_transform.origin, Vector3.UP)
			var collision = move_and_collide(Calc_Vector(Player.global_translation) * (Speed))
			pass
			
		STATE.FLEE:
			if(Changing_State):
				print("fleeing")
				look_at(Flee_Pos.global_transform.origin, Vector3.UP)
				Changing_State = false
			#move away from player
			move_and_collide(Calc_Vector(Flee_Pos.global_translation) * (Speed))
			pass

func Calc_Vector(target: Vector3) -> Vector3:
	var new_vector = Vector3(target.x - self.global_translation.x, target.y - self.global_translation.y, target.z - self.global_translation.z).normalized()
	#print(new_vector)
	return new_vector

func _on_Detection_Radius_body_entered(body):
	if(body == Player && State == STATE.PATROL):
		print("player detected")
		State = STATE.ATTACK
		Changing_State = true
		
func _on_Hurt_Radius_body_entered(body):
	print(body)
	if(body == Player):
		print("player hurt")
		Player.Take_Damage()
		Changing_State = true
		State = STATE.FLEE
	elif(body.name == "Harpoon_Projectile"):
		print("fish got SHOT")
		self.Take_Damage()
		Changing_State = true
		State = STATE.FLEE
	elif(body.name == "Boundary"):
		print("fish hit boundary")
		Changing_State = true
		State = STATE.PATROL

func Take_Damage():
	#TODO: health and stuff
	print("ouch")


