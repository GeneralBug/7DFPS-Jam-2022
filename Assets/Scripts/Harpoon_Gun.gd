extends Spatial

#TODO: does this script need to exist?

var Projectile

func SetProjectile(Ref):
	Projectile = Ref
	
func Shoot():
	#1. check if fired
	#	a. tether unlocks (TODO: max tether length?)
	#	b. shoot harpoon (anim trigger)
	#	c. **harpoon collides, sticks to object
	#	d. **tether locks
	#2. else, unloaded:
	#	a. "tug" harpoon (anim trigger)
	#		I. in object, unsticks
	#		II. in fish, chance to pull fish
	#	b. tether retracts
	#	c. **touches player, reloads 
	Projectile.Fire()

