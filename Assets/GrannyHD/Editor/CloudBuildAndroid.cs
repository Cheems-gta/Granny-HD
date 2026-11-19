using System.IO;
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;

// Called by GameCI via -executeMethod. Generates an original, stand-alone test room.
public static class CloudBuildAndroid
{
    public static void Build()
    {
        CreateGrannyHDTestRoom.Generate();
        const string scene = "Assets/GrannyHD/Scenes/GrannyHD_TestRoom_V01.unity";
        if (!File.Exists(scene)) throw new System.Exception("Scene generation failed.");
        EditorUserBuildSettings.SwitchActiveBuildTarget(BuildTargetGroup.Android, BuildTarget.Android);
        PlayerSettings.companyName = "Cheems";
        PlayerSettings.productName = "Granny HD - Prototype Test Room";
        PlayerSettings.SetApplicationIdentifier(BuildTargetGroup.Android, "win.cheems.grannyhdprototype");
        PlayerSettings.Android.bundleVersionCode = 2;
        PlayerSettings.bundleVersion = "0.2";
        PlayerSettings.defaultInterfaceOrientation = UIOrientation.LandscapeLeft;
        PlayerSettings.Android.minSdkVersion = AndroidSdkVersions.AndroidApiLevel23;
        PlayerSettings.Android.targetArchitectures = AndroidArchitecture.ARM64;
        PlayerSettings.SetScriptingBackend(BuildTargetGroup.Android, ScriptingImplementation.IL2CPP);
        EditorUserBuildSettings.buildAppBundle = false;
        Directory.CreateDirectory("build/Android");
        var options = new BuildPlayerOptions {
            scenes = new [] { scene },
            locationPathName = "build/Android/GrannyHD_MaterialTest_V0_2.apk",
            target = BuildTarget.Android,
            options = BuildOptions.None
        };
        BuildReport result = BuildPipeline.BuildPlayer(options);
        if (result.summary.result != BuildResult.Succeeded)
            throw new System.Exception("Android build failed: "+result.summary.result);
        Debug.Log("APK generated successfully.");
    }
}
