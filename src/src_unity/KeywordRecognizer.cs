using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using System.Runtime.InteropServices;
using System.ComponentModel;
using System;



[System.Serializable]
public class KeywordInstructions{
    public string keyword;
    public UnityEvent callback;
}

public class KeywordRecognizer : MonoBehaviour
{

    [DllImport("KeywordRecognizer")]
    public static extern void _C_initRecognizer();

    [DllImport("KeywordRecognizer")]
    public static extern int _C_startRecognizer();

    [DllImport("KeywordRecognizer")]
    public static extern int _C_stopRecognizer();

    [DllImport("KeywordRecognizer")]
    public static extern int _C_addKeyword(char[] key, int keyID);

    [DllImport("KeywordRecognizer")]
    public static extern int _C_setCallback(Action<int> callbackHandler);


    public KeywordInstructions[] keywordInstructions;


    private static KeywordRecognizer activeInstance = null;


    /*--------------------------------------------------------------------------------*/

    void Start()
    {
        if(activeInstance == null)
            activeInstance = this;
        else
        {
            WarningException warningEx = new WarningException("KeywordRecognizer is used by more than one instance. Only the latest instance will be used.");
            throw warningEx;
        }


        _C_initRecognizer();

        // add keywords to the recognizer
        for (int i = 0; i < keywordInstructions.Length; i += 1){
            _C_addKeyword(keywordInstructions[i].keyword.ToCharArray(), i);
        }

        _C_setCallback(staticCallback);
        _C_startRecognizer();
    }

    /*--------------------------------------------------------------------------------*/

	private void OnApplicationQuit()
	{
        _C_stopRecognizer();
	}

    /*--------------------------------------------------------------------------------*/

    public void myCallback(int keyID)
    {
        keywordInstructions[keyID].callback.Invoke();
    }

    /*--------------------------------------------------------------------------------*/

    public static void staticCallback(int keyID){
        if (activeInstance == null) return;

        activeInstance.myCallback(keyID);
    }
}
