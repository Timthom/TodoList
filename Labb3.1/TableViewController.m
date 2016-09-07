//
//  TableViewController.m
//  Labb3.1
//
//  Created by Thomas on 2016-02-24.
//  Copyright © 2016 Thomas Månsson. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property(nonatomic) NSString *stringFromDate;
@property(nonatomic, strong) UIColor *tintColor;


@end

@implementation TableViewController

-(NSMutableArray *)taskObjects {
    
    if(!_taskObjects){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    return _taskObjects;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
     self.editButtonItem.tintColor = [UIColor colorWithRed:
                                                (CGFloat)1.0
                                                green:(CGFloat)0.0
                                                 blue:(CGFloat)0.0
                                                alpha:(CGFloat)0.6];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *taskAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TODO_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in taskAsPropertyLists) {
        TODO *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.taskObjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    TODO *task = self.taskObjects [indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringForObjectValue:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if (task.isCompleted == YES) {
        cell.backgroundColor = [UIColor greenColor];
    } else if (isOverDue == YES) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:(CGFloat)0.9
                                               green:(CGFloat)0.9
                                                blue:(CGFloat)0.9
                                               alpha:(CGFloat)0.8];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TODO *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task  forIndexPath:indexPath];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

//This replaces standard method just above this one
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  /*  UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        //Get the string at indexPath.row and send to AddToDoListView
        [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:self.taskObjects[indexPath.row]];
        
    }];
    editAction.backgroundColor = [UIColor greenColor];*/
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // Delete the row from the data source
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        
        for (TODO *task in self.taskObjects) {
            [newTaskObjectsData addObject:[self todoObjectAsAPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TODO_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction /*,editAction*/];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
    
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    TODO *taskObject = [self.taskObjects objectAtIndex:fromIndexPath.row];
    [self.taskObjects removeObjectAtIndex:fromIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:toIndexPath.row];
    [self saveTasks];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.destinationViewController isKindOfClass:[AddViewController class]]){
        
        AddViewController *addToDoViewController = segue.destinationViewController;
        
        addToDoViewController.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        DetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        TODO *taskObject = self.taskObjects[path.row];
        detailViewController.task = taskObject;
        detailViewController.delegate= self;
    } /*else if ([segue.identifier isEqualToString:@"toEditTaskViewControllerSegue"]) {
        EditViewController *editToDoSegue = segue.destinationViewController;
        editToDoSegue.todo = sender;

    }*/
}


- (IBAction)AddTodoButton:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddViewControllerSegue" sender:nil];
}

#pragma mark - addViewControllerDelegate

-(void)didAddTask:(TODO *)todo {
    
    [self.taskObjects addObject:todo];
    
    NSLog(@"%@", todo.title);
    
    NSMutableArray *todoObjectsAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TODO_OBJECTS_KEY] mutableCopy];
    if (!todoObjectsAsPropertyList) todoObjectsAsPropertyList = [[NSMutableArray alloc] init];
    
    [todoObjectsAsPropertyList addObject:[self todoObjectAsAPropertyList:todo]];
    
    [[NSUserDefaults standardUserDefaults] setObject:todoObjectsAsPropertyList forKey:TODO_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DetailViewControllerDelegate

-(void)updateTodo {
    
    [self saveTasks];
    [self.tableView reloadData];
}


#pragma mark - Helper Methods

-(NSDictionary *) todoObjectAsAPropertyList:(TODO *)todoObject {
    
    NSDictionary * dictionary = @{TODO_TITLE : todoObject.title, TODO_DESCRIPTION : todoObject.detail, TODO_DATE : todoObject.date, TODO_COMPLETION  : @(todoObject.isCompleted) };
    
    return dictionary;
    
}

-(TODO *)taskObjectForDictionary: (NSDictionary *)dictionary {
    TODO *taskObject =[[TODO alloc] initWithData:dictionary];
    return taskObject;
}


-(BOOL) isDateGreaterThanDate: (NSDate *)date and:(NSDate *) toDate {
    
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) {
        return YES;
    } else {
        return NO;
    }
    
}

-(void)updateCompletionOfTask:(TODO *)task forIndexPath: (NSIndexPath *)indexPath {
    
    NSMutableArray *todoObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TODO_OBJECTS_KEY] mutableCopy];
    
    
    if(!todoObjectAsPropertyList)
        todoObjectAsPropertyList = [[NSMutableArray alloc] init];
        [todoObjectAsPropertyList removeObjectAtIndex:indexPath.row];
    
    if(task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [todoObjectAsPropertyList insertObject:[self todoObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:todoObjectAsPropertyList forKey:TODO_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}


-(void)saveTasks {
    
    NSMutableArray *todoObjectAsPropertyList = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < [self.taskObjects count]; x ++) {
        [todoObjectAsPropertyList addObject:[self todoObjectAsAPropertyList:self.taskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:todoObjectAsPropertyList forKey:TODO_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
