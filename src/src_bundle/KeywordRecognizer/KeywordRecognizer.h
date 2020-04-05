//
//  KeywordRecognizer.h
//  KeywordRecognizer
//
//  Created by Christian Krüger on 02.08.19.
//  Copyright © 2019 Christian Krüger. All rights reserved.
//

#ifndef KeywordRecognizer_h
#define KeywordRecognizer_h

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface KeywordRecognizer : NSObject <NSSpeechRecognizerDelegate>

@property (nonatomic) NSSpeechRecognizer *recognizer;
@property (nonatomic) NSMutableArray * keys;
@property (nonatomic) NSMutableArray * indices;
@property (nonatomic) void (* callBack)(int);

-(id) init;
-(void) speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(id)command;
-(void) addKeyword:(NSString*)keyword keyIndex:(int)index ;
-(void) setCallback:(void(*)(int))callBackHandler;
-(void) start;
-(void) stop;

@end

#endif /* KeywordRecognizer_h */
