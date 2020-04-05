//
//  KeywordRecognizer.m
//  KeywordRecognizer
//
//  Created by Christian Krüger on 02.08.19.
//  Copyright © 2019 Christian Krüger. All rights reserved.
//

#import "KeywordRecognizer.h"

@implementation KeywordRecognizer

- (id)init
{
    if ((self = [super init])) {
        
        self.callBack = nil;
        
        if(!self.keys) self.keys = [[NSMutableArray alloc] init];
        if(!self.indices) self.indices = [[NSMutableArray alloc] init];
        
        
        self.recognizer = [[NSSpeechRecognizer alloc] init];
        self.recognizer.listensInForegroundOnly = NO;
        self.recognizer.blocksOtherRecognizers = YES;
        self.recognizer.delegate = self;
        self.recognizer.commands = self.keys;
    }
    
    return self;
}


- (void)speechRecognizer:(NSSpeechRecognizer *)sender didRecognizeCommand:(id)command
{
    int index = 0;
    for(id key in self.keys){
        if ([key isKindOfClass:[NSString class]]) {
            if([(NSString*) command isEqualToString:((NSString*) key)]){
                //                NSLog((NSString*) key);
                if(self.callBack){
                    NSNumber *keyID = (NSNumber*) [self.indices objectAtIndex:index];
                    self.callBack([keyID intValue]);
                }
            }
        }
        ++index;
    }
}


- (void)addKeyword:(NSString *)keyword keyIndex:(int) index
{
    [self.keys addObject:keyword];
    [self.indices addObject:[NSNumber numberWithInteger:index]];
    return;
}

- (void) setCallback:(void(*)(int))callBackHandler
{
    self.callBack = callBackHandler;
    return;
}


- (void)start
{
    [self.recognizer setDelegate:self];
    [self.recognizer setCommands:self.keys];
    [self.recognizer startListening];
}

- (void)stop
{
    [self.recognizer stopListening];
}


@end
