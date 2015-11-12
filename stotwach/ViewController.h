//
//  ViewController.h
//  stotwach
//
//  Created by Oliiver Yepez on 11/1/15.
//  Copyright © 2015 Oliver Yepez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnStartTimer;
@property (weak, nonatomic) IBOutlet UIButton *btnLap;
@property (weak, nonatomic) IBOutlet UIView *ViewTimerContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) NSMutableArray *laps;

@property (weak, nonatomic) IBOutlet UITableView *lapsTableView;
@property int *secondsElapsed;

- (IBAction)onStartPressed:(id)sender;
- (IBAction)onLapPressed:(id)sender;

@end

