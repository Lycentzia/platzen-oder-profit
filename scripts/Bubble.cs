using Godot;
using System;

public partial class Bubble : StaticBody3D
{

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	public void  destroyBubble(){
		AnimationPlayer player = GetNode<AnimationPlayer>("MeshInstance3D/AnimationPlayer");
		player.Play("DestroyBubble");
	}	
}
