//
//  AddViewController.m
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    self.textField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self buttonSetup:self.addButton borderColor:[UIColor greenColor]];
    [self buttonSetup:self.cancelButton borderColor:[UIColor redColor]];
    
}
- (void)buttonSetup:(UIButton *)button borderColor:(UIColor *)borderColor
{
    button.layer.cornerRadius = button.bounds.size.width/2;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor =[borderColor CGColor];
    button.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(TODO *)returnNewTodoObject {
    TODO *todoObject = [[TODO alloc] init];
    todoObject.title = self.textField.text;
    todoObject.detail = self.textView.text;
    todoObject.date = self.datePicker.date;
    todoObject.isCompleted = NO;
    
    return todoObject;
}

- (IBAction)addToDoButtonPressed:(UIButton *)sender {
    [self.delegate didAddTask:[self returnNewTodoObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
     [self.delegate didCancel];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *) textField {
    
    [self.textField resignFirstResponder];
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}




@end
