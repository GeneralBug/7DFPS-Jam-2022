using Godot;
using System;

public class Harpoon_Projectile : KinematicBody
{

	[Export]
	private string ID = "default";
	private bool FireFlag = false;
	[Export]
	private float Speed = 0.5f;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	public string GetID()
	{
		return ID;
	} 
//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
	public override void _PhysicsProcess(float delta)
	{
		if(FireFlag)
		{
			MoveAndCollide(Transform.basis.Xform(new Vector3(Speed, 0, 0).Normalized()));
			FireFlag = false;
		}
	}
		
	public void Fire()
	{
		FireFlag = true;
	}
	
}
