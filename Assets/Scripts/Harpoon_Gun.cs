using Godot;
using System;

public class Harpoon_Gun : Spatial
{
	//stores if harpoon is away
	private bool Loaded = true;
	private Harpoon_Projectile Projectile;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("harpoon gun ");
	}

	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
	//  public override void _Process(float delta)
	//  {
	//      
	//  }
	public void SetProjectile(Harpoon_Projectile Ref)
	{
		Projectile = Ref;
	}
	
	public void Shoot()
	{
		/*
		1. check if fired
			a. tether unlocks (TODO: max tether length?)
			b. shoot harpoon (anim trigger)
			c. **harpoon collides, sticks to object
			d. **tether locks
		2. else, unloaded:
			a. "tug" harpoon (anim trigger)
				I. in object, unsticks
				II. in fish, chance to pull fish
			b. tether retracts
			c. **touches player, reloads 
		*/
		// ** = handled in projectile script
		GD.Print("bang");
		if(Loaded)
		{
			GD.Print("loaded, firing " + Projectile.GetID());
			//Loaded = false;
			//TODO: unlock tether
			//TODO: trigger gun animation
			Projectile.Fire();
			
		}
		else
		{
			GD.Print("unloaded, retracting " + Projectile.GetID());
		}
		
	}
}
