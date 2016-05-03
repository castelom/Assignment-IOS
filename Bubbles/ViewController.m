//
//  ViewController.m
//  Bubbles
//
//  Created by Joao Victor Castelo on 23/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *volumeButton;



@end

bool ismute = false;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"background.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButton:(id)sender {
    [self performSegueWithIdentifier:@"game" sender:nil];
    
}
- (IBAction)settingsAction:(id)sender {
    [self performSegueWithIdentifier:@"settings" sender:nil];
}
- (IBAction)volumesAction:(id)sender {
    if(ismute == false){
    [_volumeButton setImage:[UIImage imageNamed:@"mute.png"] forState:UIControlStateNormal];
        ismute = true;
    }
    else{
        [_volumeButton setImage:[UIImage imageNamed:@"volume.ico"] forState:UIControlStateNormal];
        ismute = false;
    }
}

@end
