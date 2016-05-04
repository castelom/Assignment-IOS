//
//  GameController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 28/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "GameController.h"
#import "BubbleCollection.h"
#import "Bubble.h"


@interface GameController ()
@property (weak, nonatomic) IBOutlet UILabel *label_score;
@property (weak, nonatomic) IBOutlet UILabel *label_timer;
@property (strong, nonatomic) NSMutableArray* bubbles;
@property int score;
@property int remain_time;
@property int max_bubbles;
@property NSTimer* timer;
@end

@implementation GameController

- (void)viewDidLoad {
    [self initView];
    [self ConfigureController];/*
    Bubble * test = [Bubble alloc];
    test = [test initBubble:@"Black" with:40 withX:0 withY:self.view.frame.size.height-60];
    [test setFrame:CGRectMake(test.position_x, test.position_y, widthBubble, heightBubble)];
    [self.view addSubview: test];
    NSLog(@"position %f %f", test.position_x, test.position_y);
                                */
}

-(void)UpdateTime{
    if(self.remain_time == 0){
        self.label_timer.text = [NSString stringWithFormat:@"Time  %d", self.remain_time];
        [self.timer invalidate];
    }
    else{
        self.label_timer.text = [NSString stringWithFormat:@"Time  %d", self.remain_time];
        self.remain_time--;
        [BubbleCollection ChangeBubbles:self.bubbles withMAXBubbles:self.max_bubbles withFramewidht:self.view.frame.size.width withFrameheight:self.view.frame.size.height];
    }
}

-(void)initView{
    [super viewDidLoad];
    self.score = 0;
    self.remain_time = 10;
    self.max_bubbles = 4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(UpdateTime) userInfo:nil repeats:YES];
    [self.timer fire];
}



/*Controller Methods*/
-(void)ConfigureController{
    [self registerNotifications];
    self.label_score.text = [NSString stringWithFormat:@"Score    %d",self.score];
    self.bubbles = [BubbleCollection CreateBubbles:self.max_bubbles withFrameX: self.view.frame.size.width withFrameY:self.view.frame.size.height];
}
-(void) registerNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"ADD_BUBBLES"    object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"REMOVE_BUBBLE" object:nil];
    
}

-(void) receiveNotification: (NSNotification *) notification{
    if([[notification name] isEqualToString:@"ADD_BUBBLES"]){
        [self addBubbles:notification.object];
    }
    else if([[notification name] isEqualToString:@"REMOVE_BUBBLE"]){
        [self RemoveBubbleWithAnimation:notification.object];
    }
    
}
//Controller

//Notifications Methods
-(void) addBubbles: (NSMutableArray*) my_bubbles{
    Bubble * new_b = nil;
    for(int i = 0; i < [my_bubbles count]; i++){
        new_b = (Bubble*) my_bubbles[i];
        [new_b setFrame:CGRectMake(new_b.position_x, new_b.position_y, widthBubble, heightBubble)];
        [new_b addTarget:self action:@selector(playBubble:) forControlEvents:UIControlEventTouchUpInside];
        
        CGAffineTransform trans = CGAffineTransformScale(new_b.transform, 0.01, 0.01);
        new_b.transform = trans;
        [self.view addSubview: new_b];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            new_b.transform  = CGAffineTransformScale(new_b.transform, 100.0, 100.0);
             }completion:nil];
        
    }
}

-(void) RemoveBubbleWithAnimation: (Bubble *) bubble{
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         bubble.transform = CGAffineTransformScale(bubble.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [bubble removeFromSuperview];
                     }];
    
    //[BubbleCollection PrintArray:self.bubbles];
}
//Notification Methods


- (IBAction)playBubble:(id)sender {
    Bubble *b = (Bubble*) sender;
    self.score += b.pointBubble;
    self.label_score.text = [NSString stringWithFormat:@"Score    %d",self.score];
    [BubbleCollection RemoveBubbles:b in:self.bubbles];
    
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

@end
