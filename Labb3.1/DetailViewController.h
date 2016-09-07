//
//  DetailViewController.h
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TODO.h"
#import "EditViewController.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void)updateTodo;

@end

@interface DetailViewController : UIViewController<EditViewControllerDelegate>

@property (strong, nonatomic) TODO *task;
@property (weak, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;

@end
