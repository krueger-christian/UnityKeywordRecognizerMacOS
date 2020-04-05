//
//  UnityBridge.m
//  KeyWordRecognizerTest
//
//  Created by Christian Krüger on 25.03.20.
//  Copyright © 2020 Christian Krüger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnityBridge.h"

@implementation UnityBridge : NSObject

static KeywordRecognizer *keywordRecognizer;

+(void)initRecognizer
{
    if(!keywordRecognizer)
    {
        keywordRecognizer = [[KeywordRecognizer alloc] init];
    }
}

+(void)startRecognizer
{
    if(!keywordRecognizer){
        [self initRecognizer];
    }
    
    [keywordRecognizer start];
}

+(void)stopRecognizer
{
    if(!keywordRecognizer){
        return;
    }
    
    [keywordRecognizer stop];
    keywordRecognizer = nil;
}

+(void)setCallback:(void(*)(int))callBackHandler
{
    if(!keywordRecognizer){
        return;
    }
    
    [keywordRecognizer setCallback:callBackHandler];
}

+(void)addKeyword:(NSString*)keyword keyIndex:(int)index ;
{
    if(!keywordRecognizer){
        return;
    }
    
    [keywordRecognizer addKeyword:keyword keyIndex:index];
}

@end


void _C_startRecognizer()
{
    [UnityBridge startRecognizer];
}

void _C_stopRecognizer()
{
    [UnityBridge stopRecognizer];
}

void _C_initRecognizer()
{
    [UnityBridge initRecognizer];
}

void _C_addKeyword(char* key, int keyID)
{
    NSString *str = [NSString stringWithFormat:@"%s", key];
    [UnityBridge addKeyword:str keyIndex:keyID];
    return;
}

void _C_setCallback(void (*func)(int))
{
    [UnityBridge setCallback:func];
    return;
}
