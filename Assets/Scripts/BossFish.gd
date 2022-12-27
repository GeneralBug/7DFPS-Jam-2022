extends KinematicBody

enum STATE {ATTACK, PATROL, FLEE, DEAD}
var State = STATE.PATROL

export var Animator_Path: NodePath
export var Patrol_Agent_Path: NodePath
export var Flee_Path: NodePath
var Animator
var Patrol_Agent 
var Flee_Pos
onready var Player = $"../../Player"
var Target_Point: int = 0
export var Speed: float = 1
var Changing_State: bool = true
export var Health: int = 3

func _ready():
	Animator = get_node(Animator_Path)
	Patrol_Agent = get_node(Patrol_Agent_Path)
	Flee_Pos = get_node(Flee_Path)
	
	if(!Animator.is_playing()):
		Animator.play("swim")

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
			var _warn1 = move_and_collide(Calc_Vector(Patrol_Agent.global_translation) * Speed)
			pass
			
		STATE.ATTACK:
			if(Changing_State):
				print("attacking")
				Changing_State = false
			#follow player
			look_at(Player.global_transform.origin, Vector3.UP)
			var _warn2 = move_and_collide(Calc_Vector(Player.global_translation) * (Speed))
			pass
			
		STATE.FLEE:
			if(Changing_State):
				print("fleeing")
				look_at(Flee_Pos.global_transform.origin, Vector3.UP)
				Changing_State = false
			#move away from player
			var _warn3 = move_and_collide(Calc_Vector(Flee_Pos.global_translation) * (Speed))
			pass
			
		STATE.DEAD:
			if(Changing_State):
				print("DEAD FISH!!")
				Animator.play("death")
				Changing_State = false
				#TODO: contribute to victory condition
			var _warn4 = move_and_slide(Vector3.UP)
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
	if(State != STATE.DEAD):
		if(body == Player):
			print("player hurt")
			Player.Take_Damage()
			State = STATE.FLEE
			Changing_State = true
			
		elif(body.name == "Harpoon_Projectile" && body.Check_Collision()):
			print("fish got SHOT")
			Health = Health - 1
			print("fish health:")
			print(Health)
			if(Health <= 0):
				State = STATE.DEAD
			else:
				State = STATE.FLEE
			Changing_State = true
			
		elif(body.name == "Boundary"):
			print("fish hit boundary")
			Changing_State = true
			State = STATE.PATROL


func _on_Barracuda_Animator_animation_started(_anim_name):
	pass # Replace with function body.

func _on_AnimationPlayer_animation_started(_anim_name):
	pass
