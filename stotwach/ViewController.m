//
//  ViewController.m
//  stotwach
//
//  Created by Oliiver Yepez on 11/1/15.
//  Copyright © 2015 Oliver Yepez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSTimer *stopTimer;
    NSDate *startDate;
    NSString *lapTime;
    BOOL running;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** Set round btn_start **/
   _btnStartTimer.titleLabel.textColor = [UIColor greenColor];
    _btnStartTimer.layer.cornerRadius = _btnStartTimer.bounds.size.width / 2;
    _btnStartTimer.layer.borderWidth = 1.0f;
    _btnStartTimer.layer.borderColor = [UIColor greenColor].CGColor;
    
    /** Set round btn_lapt **/
    _btnLap.layer.cornerRadius = _btnLap.bounds.size.width / 2;
    _btnLap.layer.borderWidth = 1.0f;
    _btnLap.layer.borderColor = [UIColor grayColor].CGColor;
    
    running = NO;
    startDate = [NSDate date];
    _laps = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onStartPressed:(id)sender {
    if(!running){
        running = YES;
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _btnStartTimer.layer.borderColor = [UIColor redColor].CGColor;
        
        [self updateTimer];
        
        if(stopTimer == nil){
            stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                         target:self
                                                       selector:@selector(updateTimer)
                                                       userInfo:nil
                                                        repeats:YES];
        }
    }else{
        [stopTimer invalidate];
         stopTimer = nil;
        [sender setTitle:@"Start" forState: UIControlStateNormal];
        _btnStartTimer.layer.borderColor = [UIColor greenColor].CGColor;
        [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        startDate = [NSDate date];
        _lblTime.text = @"00:00:00.000";
        running = NO;
    }

}

- (IBAction)onLapPressed:(id)sender {
    [stopTimer invalidate];
    stopTimer = nil;
    startDate = [NSDate date];
    _lblTime.text = @"00:00:00.000";
    running = YES;
    
    stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                 target:self
                                               selector:@selector(updateTimer)
                                               userInfo:nil
                                                repeats:YES];
    [_laps addObject:lapTime];
    [_lapsTableView reloadData];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_laps count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableIdentifier = @"lapTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    cell.textLabel.text = [_laps objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) updateTimer{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    
    _lblTime.text = timeString;
    lapTime = timeString;
    
}

@end
