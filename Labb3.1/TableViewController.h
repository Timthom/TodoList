//
//  TableViewController.h
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
#import "DetailViewController.h"


@interface TableViewController : UITableViewController <AddViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, DetailViewControllerDelegate>

@property (nonatomic) NSMutableArray *taskObjects;



- (IBAction)AddTodoButton:(UIBarButtonItem *)sender;

@end
