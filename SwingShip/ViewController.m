//
//  ViewController.m
//  SwingShip
//
//  Created by Xmob - Longdt on 5/16/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    UIImageView *ship;
    UIImageView *sea1, *sea2;
    AVAudioPlayer *audioPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShipAndSea];
    [self animateShip];
    [self animateSea];
    [self playSong];
 
}

- (void) drawShipAndSea{
    
    
    sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea01.png"]];
    sea1.frame = self.view.bounds;
    [self.view addSubview:sea1];
    
    sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea02.png"]];
    sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sea2];
    
    ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship.png"]];
    ship.center = CGPointMake(200, 400);
    [self.view addSubview:ship];
}

- (void) animateShip{
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.08);
    }completion:^(BOOL finished){
        [UIView animateWithDuration:1 animations:^{
            ship.transform = CGAffineTransformMakeRotation(0.08);
        }completion:^(BOOL finished){
            [self animateShip];
        }];
    }];
}

-(void) animateSea{
    [UIView animateWithDuration:5 animations:^{
        sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        sea2.frame = self.view.bounds;
    }completion:^(BOOL finished) {
        sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView animateWithDuration:5 animations:^{
            sea1.frame = self.view.bounds;
            sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
            sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [self animateSea];
        }];
    }];
}

-(void) playSong{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"adagio" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL: url
                                                        error:&error]; //truyen vao dia chi con tro
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
//ham chuan cua view controler -> view chuan bi bien mat se stop khong choi nhac nua
- (void) viewWillDisappear:(BOOL)animated{
    [audioPlayer stop];
}

@end
