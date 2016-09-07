//
//  EditViewController.h
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TODO.h"

@protocol EditViewControllerDelegate <NSObject>

-(void)didUpdateTodo;

@end

@interface EditViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong,nonatomic) TODO *todo;
@property (weak, nonatomic) id <EditViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;



@end
