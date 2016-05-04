//
//  SettingsController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 28/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *timer_options;
@property (weak, nonatomic) IBOutlet UISlider *bubbles_option;
@property (weak, nonatomic) IBOutlet UILabel *bubbles_label;
@property (weak, nonatomic) IBOutlet UIButton *save_button;
@end

@implementation SettingsController



int timer_segment = 0;
int timer = 60;
int num_bubbles = 15;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.bubbles_label.text = [@(num_bubbles) stringValue];
    self.bubbles_option.value = (float) num_bubbles;
    [self.timer_options setSelectedSegmentIndex:timer_segment];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaveSettings:(id)sender {
    //[self performSegueWithIdentifier:@"home_screen" sender:nil];
    NSLog(@"time = %d, Max_bubbles = %d", timer, num_bubbles);
}
- (IBAction)ChooseTimer:(id)sender {
    UISegmentedControl* timer_control = (UISegmentedControl*) sender;
    timer_segment = (int)[timer_control selectedSegmentIndex];
    NSString* string_timer = [timer_control titleForSegmentAtIndex:[timer_control selectedSegmentIndex]];
    timer = (int)[string_timer integerValue];
    
}
- (IBAction)ChooseBubbles:(id)sender {
    UISlider* slider = (UISlider *) sender;
    self.bubbles_label.text = [NSString stringWithFormat:@"%d", (int) slider.value];
    num_bubbles = (int)[self.bubbles_label.text integerValue];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
