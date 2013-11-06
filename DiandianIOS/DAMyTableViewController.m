//
//  DAMyTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyTableViewController.h"

@interface DAMyTableViewController ()
{
        MSGridView *gridView;
}
@end

@implementation DAMyTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    gridView = [[MSGridView alloc] initWithFrame:CGRectMake(0, 0, 1024, 700)];
    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    [gridView setInnerSpacing:CGSizeMake(0, 0)];
    [self.view addSubview:gridView];
    // Do any additional setup after loading the view from its nib.
}



#pragma mark gridView delegate methods

#pragma mark gridView datasource methods


-(MSGridViewCell *)cellForIndexPath:(NSIndexPath*)indexPath inGridWithIndexPath:(NSIndexPath *)gridIndexPath;
{
    
    static NSString *reuseIdentifier = @"cell";
    MSGridViewCell *cell = [MSGridView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil) {
        cell = [[MSGridViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:reuseIdentifier];
    }
    
    cell.layer.borderWidth = 1;
    return cell;
    
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridRows
{
    return 1;
}

// Returns the number of supergrid rows
-(NSUInteger)numberOfGridColumns
{
    return 3;
}


-(NSUInteger)numberOfColumnsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 5;
    
}

-(NSUInteger)numberOfRowsForGridAtIndexPath:(NSIndexPath*)indexPath
{
    return 5;
}

/*
 * If you want to specify a height
 *
 
 
 -(float)heightForCellRowAtIndex:(NSUInteger)row forGridAtIndexPath:(NSIndexPath *)gridIndexPath
 {
 NSLog(@"call");
 return self.view.frame.size.width*1.2/3;
 }
 */


-(void)didSelectCellWithIndexPath:(NSIndexPath*) indexPath
{
    
    int index = [indexPath indexAtPosition:2]*3+[indexPath indexAtPosition:3];
    NSLog(@"index: %i",index);
    
    [[[UIAlertView alloc] initWithTitle:@"Tapped" message:[NSString stringWithFormat:@"You tapped cell %i in grid (%i,%i)",index,[indexPath indexAtPosition:0],[indexPath indexAtPosition:1]] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
