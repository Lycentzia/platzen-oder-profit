using Godot;
using Godot.Collections;
using System;
using System.Runtime.InteropServices;
using System.Transactions;

public partial class placer : Node3D
{
	public Vector3 place;
	//private PackedScene building = GD.Load<PackedScene>("res://buildings/cube.tscn");

	[Export]
	public PackedScene[] building {get; set;}

	[Export]
	public Button[] buttons {get; set; }

	[Export]
	public Camera3D camera3D;

	[Export]
	public StaticBody3D bubble;

	private bool placeNow { get; set; } = false;

	private RayCast3D rayCast3D;
	private System.Collections.ArrayList allBuildings = new System.Collections.ArrayList();
	private PackedScene currentBuilding;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		foreach(var build in building){
			GD.Print(build.ResourcePath);
			var b = GD.Load<PackedScene>(build.ResourcePath);
			allBuildings.Add(b);
		}
		//GD.Print("allBuildings[0]");
		foreach(Button button in buttons )

			//button.Connect("pressed", new Callable(this, "loadObject"). );
			button.Connect("pressed",Callable.From(() => loadObject(button)));
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		if(Input.IsActionJustPressed("mouse_leftclick") && placeNow){
			var raylength = 1000;
			var mousepos = GetViewport().GetMousePosition();
			
			//var camera3D = GetParent().GetNode<Camera3D>("CameraPivot/Camera3D");
        	var from = camera3D.ProjectRayOrigin(mousepos);
        	var to = from + camera3D.ProjectRayNormal(mousepos) * raylength;
			PhysicsDirectSpaceState3D space_state = GetWorld3D().DirectSpaceState;
			var query = PhysicsRayQueryParameters3D.Create(from, to);
			//query.Exclude = new Godot.Collections.Array<Rid> { GetParent().GetNode<StaticBody3D>("Sphere").GetRid() };
			query.Exclude = new Godot.Collections.Array<Rid> { bubble.GetRid() };
			query.CollideWithAreas = true;

			var result = space_state.IntersectRay(query);
			GD.Print((Vector3) result["position"]);
			createObject((Vector3)result["position"]);
		}
	}

	private void createObject(Vector3 pos){
		//Node3D ibuilding = (Node3D) building.Instantiate();
		//Node3D ibuilding = (Node3D) ((PackedScene) allBuildings[0]).Instantiate();
		Node3D ibuilding = (Node3D) currentBuilding.Instantiate();
		ibuilding.Position = pos;
		GetParent().AddChild(ibuilding);
		placeNow = false;
	}

	public void loadObject(Button button){
		GD.Print(button.Name);
		String name = button.Name.ToString();
		int n = name.Substring(name.Length -1 , 1).ToInt();
		//button.Name.ToString().Substring(button.Name.ToString() - 1, 1)[0];
		//((PackedScene) allBuildings[0]).Instantiate();
		currentBuilding = (PackedScene) allBuildings[n];
		placeNow = true;
	}

	
}
