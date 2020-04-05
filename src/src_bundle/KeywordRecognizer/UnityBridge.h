//
//  UnityBridge.h
//  KeyWordRecognizerTest
//
//  Created by Christian Krüger on 25.03.20.
//  Copyright © 2020 Christian Krüger. All rights reserved.
//

#ifndef UnityBridge_h
#define UnityBridge_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "KeywordRecognizer.h"

@interface UnityBridge : NSObject

@end

void _C_startRecognizer();

void _C_stopRecognizer();

void _C_initRecognizer();

void _C_addKeyword(char* key, int keyID);

void _C_setCallback(void (*func)(int));

#endif /* UnityBridge_h */
