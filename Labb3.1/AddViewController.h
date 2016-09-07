//
//  AddViewController.h
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TODO.h"

@protocol AddViewControllerDelegate <NSObject>

-(void) didCancel;
-(void) didAddTask: (TODO *)todo;

@end


@interface AddViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <AddViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addToDoButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;



@end
