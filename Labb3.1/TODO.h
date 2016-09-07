//
//  TODO.h
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"

@interface TODO : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *detail;
@property (nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;


-(id) initWithData: (NSDictionary *)data;

@end
