extends KinematicBody

export var ID = "default"
enum STATE {LOADED, FIRING, LANDED, RETRACTING}
var State = STATE.LOADED
var Changing_State = true
export var Speed: float = 0.5
onready var Harpoon_Gun = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun"
onready var Player = $"../Player"
onready var Fake_Harpoon = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun/Fake_Harpoon"
onready var Tether_Anchor = $"../Player/Camera Anchor/Harpoon/Harpoon_Gun/Tether_Anchor"
var Collision

#gravity
var gravity_local = Vector3()
export var Gravity_Acceleration: float = 0.001


func GetID() -> String:
	return ID
	
func _physics_process(delta):
		#gravity
	if not is_on_floor():
		gravity_local += Gravity_Acceleration * Vector3.DOWN * delta
	else:
		gravity_local = Gravity_Acceleration * -1 * get_floor_normal() * delta
	
	match State:
		STATE.LOADED: #follow gun
			if(Changing_State):
				#TODO: remove rope
				Fake_Harpoon.show()
				self.hide()
				#turns on collision with obstacles and fish
				self.set_collision_mask_bit(1, true)
				self.set_collision_mask_bit(4, true)
				Changing_State = false
				
		STATE.FIRING: 
			if(Changing_State):
				#TODO: add rope
				self.global_transform = Harpoon_Gun.global_transform
				Fake_Harpoon.hide()
				self.show()
				Changing_State = false
			Collision = move_and_collide(transform.basis.xform(Vector3(0, 0, 1)* Speed) + gravity_local)
			if(Collision):
				Collide(Collision)
			
		STATE.LANDED:
			if(Changing_State):
				#TODO: freeze rope length
				Changing_State = false
			
		STATE.RETRACTING:
			if(Changing_State):
				print("retracting")
				#turns off collision with obstacles and fish
				self.set_collision_mask_bit(1, false)
				self.set_collision_mask_bit(4, false)
				Changing_State = false

			look_at(Player.global_transform.origin, Vector3.UP)
			Collision = move_and_collide(Calc_Vector()* Speed/2)
			if(Collision):
				Collide(Collision)
			
func Fire():
	if(State == STATE.LOADED):
		#TODO: animation
		Changing_State = true
		State = STATE.FIRING
	elif(State == STATE.LANDED):
		#TODO: animation
		Changing_State = true
		State = STATE.RETRACTING

func Collide(collision: KinematicCollision):
	print(collision.get_collider())
	Changing_State = true
	if(collision.get_collider().name == "Player"):
		print("loading")
		State = STATE.LOADED
	elif(State != STATE.RETRACTING):
		print("landed")
		State = STATE.LANDED
		#TODO: handle fish damage in fish script

func Calc_Vector() -> Vector3:
	var new_vector = Vector3(Player.translation.x - self.translation.x, 0, Player.translation.z - self.translation.z).normalized()
	print(new_vector)
	return new_vector
