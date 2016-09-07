//
//  TODO.m
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import "TODO.h"

@implementation TODO

-(id) initWithData: (NSDictionary *)data {
    
    self = [super init];
    
    if (self) {
        self.title = data[TODO_TITLE];
        self.detail = data[TODO_DESCRIPTION];
        self.date = data[TODO_DATE];
        self.isCompleted =[data[TODO_COMPLETION] boolValue];
    }
    return self;
}

-(id) init {
    
    self = [self initWithData:nil];
    
    return self;
}

@end
