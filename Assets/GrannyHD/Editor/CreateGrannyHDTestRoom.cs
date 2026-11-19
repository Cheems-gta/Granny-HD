using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

// Independent geometry/material test scene. No original Granny geometry or scripts.
public static class CreateGrannyHDTestRoom
{
    const string Root = "Assets/GrannyHD";
    [MenuItem("Granny HD/Create Test Room")]
    public static void Generate()
    {
        Directory.CreateDirectory(Root + "/Scenes");
        var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
        RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Flat;
        RenderSettings.ambientLight = new Color(.16f,.18f,.21f);
        RenderSettings.fog = true;
        RenderSettings.fogMode = FogMode.Exponential;
        RenderSettings.fogColor = new Color(.07f,.08f,.1f);
        RenderSettings.fogDensity = .026f;
        var floor = Mat("Floor",new Color(.23f,.22f,.22f));
        var wall = Mat("Walls",new Color(.32f,.33f,.30f));
        var ceiling = Mat("Ceiling",new Color(.2f,.19f,.18f));
        var safe = Mat("SafeBody",new Color(.20f,.24f,.27f));
        var safeDoor = Mat("SafeDoor",new Color(.24f,.26f,.27f));
        var wood = Mat("Crate",new Color(.30f,.23f,.15f));
        var metal = Mat("CrateMetal",new Color(.22f,.23f,.22f));
        var plate = Mat("SteelPlate",new Color(.29f,.28f,.28f));
        Box("Floor",new Vector3(0,-.2f,0),new Vector3(9,.4f,9),floor);
        Box("Ceiling",new Vector3(0,3.1f,0),new Vector3(9,.2f,9),ceiling);
        Box("North wall",new Vector3(0,1.48f,4.5f),new Vector3(9,3.2f,.25f),wall);
        Box("South wall",new Vector3(0,1.48f,-4.5f),new Vector3(9,3.2f,.25f),wall);
        Box("West wall",new Vector3(-4.5f,1.48f,0),new Vector3(.25f,3.2f,9),wall);
        Box("East wall",new Vector3(4.5f,1.48f,0),new Vector3(.25f,3.2f,9),wall);
        GameObject safeRoot=new GameObject("SAFE - TEST PROP");
        safeRoot.transform.position=new Vector3(-2.4f,0,2.65f);
        ChildBox(safeRoot.transform,"Safe body",new Vector3(0,.85f,0),new Vector3(1.2f,1.65f,.85f),safe);
        ChildBox(safeRoot.transform,"Front rim",new Vector3(0,.85f,-.44f),new Vector3(1.17f,1.62f,.05f),metal);
        Transform door=new GameObject("Safe door pivot").transform;
        door.SetParent(safeRoot.transform,false);
        door.localPosition=new Vector3(-.55f,.85f,-.53f);
        ChildBox(door,"Safe door",new Vector3(.55f,0,0),new Vector3(1.08f,1.45f,.09f),safeDoor);
        ChildBox(door,"Knob",new Vector3(.9f,0,-.1f),new Vector3(.17f,.17f,.13f),metal);
        var si=safeRoot.AddComponent<HDInteractable>();
        si.hingedObject=door;
        si.openedEuler=new Vector3(0,-105,0);
        GameObject crateRoot=new GameObject("CRATE - TEST PROP");
        crateRoot.transform.position=new Vector3(1.5f,.03f,2.7f);
        ChildBox(crateRoot.transform,"Crate body",new Vector3(0,.5f,0),new Vector3(1.28f,1,.95f),wood);
        foreach(float x in new float[]{-.61f,.61f})
            ChildBox(crateRoot.transform,"Metal strap",new Vector3(x,.5f,-.48f),new Vector3(.085f,1.01f,.055f),metal);
        Transform lid=new GameObject("Crate lid pivot").transform;
        lid.SetParent(crateRoot.transform,false);
        lid.localPosition=new Vector3(0,1.01f,.47f);
        ChildBox(lid,"Top lid",new Vector3(0,0,-.47f),new Vector3(1.34f,.1f,1),wood);
        var ci=crateRoot.AddComponent<HDInteractable>();
        ci.hingedObject=lid;
        ci.openedEuler=new Vector3(-75,0,0);
        Box("Rusted iron plate",new Vector3(2.9f,1.2f,4.17f),new Vector3(1.55f,1.55f,.08f),plate);
        Box("Plate bracket left",new Vector3(2.19f,1.2f,4.1f),new Vector3(.09f,1.62f,.13f),metal);
        Box("Plate bracket right",new Vector3(3.61f,1.2f,4.1f),new Vector3(.09f,1.62f,.13f),metal);
        Box("Wood test cube",new Vector3(-3f,.45f,-1.4f),new Vector3(.9f,.9f,.9f),wood);
        Box("Metal test cube",new Vector3(3f,.45f,-1.4f),new Vector3(.9f,.9f,.9f),metal);
        var lightObject=new GameObject("Ceiling point light");
        lightObject.transform.position=new Vector3(0,2.85f,0);
        var light=lightObject.AddComponent<Light>();
        light.type=LightType.Point;
        light.color=new Color(.82f,.91f,1);
        light.intensity=3.5f;
        light.range=9;
        light.shadows=LightShadows.Soft;
        var player=new GameObject("Player / CharacterController");
        player.transform.position=new Vector3(0,.05f,-2.3f);
        var cc=player.AddComponent<CharacterController>();
        cc.height=1.72f; cc.radius=.27f; cc.center=new Vector3(0,.87f,0); cc.stepOffset=.25f;
        var camPivot=new GameObject("Camera Pivot").transform;
        camPivot.SetParent(player.transform,false);
        camPivot.localPosition=new Vector3(0,1.52f,0);
        var camera=camPivot.gameObject.AddComponent<Camera>();
        camera.tag="MainCamera";
        camera.fieldOfView=72;
        camera.nearClipPlane=.07f;
        camera.farClipPlane=60;
        player.AddComponent<AudioListener>();
        player.AddComponent<HDExplorer>().cameraPivot=camPivot;
        EditorSceneManager.MarkSceneDirty(scene);
        EditorSceneManager.SaveScene(scene,Root+"/Scenes/GrannyHD_TestRoom_V01.unity");
        AssetDatabase.SaveAssets(); AssetDatabase.Refresh();
        Debug.Log("Test room generated. Without original PNGs this scene intentionally uses flat placeholder materials.");
    }
    static GameObject Box(string label,Vector3 pos,Vector3 size,Material mat)
    {
        var go=GameObject.CreatePrimitive(PrimitiveType.Cube);
        go.name=label;go.transform.position=pos;go.transform.localScale=size;
        go.GetComponent<Renderer>().sharedMaterial=mat;
        return go;
    }
    static GameObject ChildBox(Transform parent,string label,Vector3 pos,Vector3 size,Material mat)
    {
        var go=Box(label,Vector3.zero,size,mat);
        go.transform.SetParent(parent,false);go.transform.localPosition=pos;
        return go;
    }
    static Material Mat(string key,Color fallback)
    {
        Directory.CreateDirectory(Root+"/Materials");
        string path=Root+"/Materials/"+key+".mat";
        Material mat=AssetDatabase.LoadAssetAtPath<Material>(path);
        if(!mat)
        {
            Shader shader=Shader.Find("Standard");
            if(!shader) shader=Shader.Find("Diffuse");
            mat=new Material(shader);
            AssetDatabase.CreateAsset(mat,path);
        }
        mat.color=fallback;
        var texture=AssetDatabase.LoadAssetAtPath<Texture2D>(Root+"/Textures/"+key+"/Albedo.png");
        if(texture) {mat.mainTexture=texture;mat.color=Color.white;}
        EditorUtility.SetDirty(mat);
        return mat;
    }
}
