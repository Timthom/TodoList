//
//  DetailViewController.m
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.detail;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringForObjectValue:_task.date];
    
    self.dateLabel.text = stringFromDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using
    if ([segue.destinationViewController isKindOfClass:[EditViewController class]]) {
        EditViewController *editViewController = segue.destinationViewController;
        editViewController.todo = self.task;
        editViewController.delegate = self;
    }
    // Pass the selected object to the new view controller.
    
}


- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditViewControllerSegue" sender:nil];
}

-(void)didUpdateTodo {
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.detail;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTodo];
    
}







@end
