//
//  SettingsViewController.h
//  Dezoito
//
//  Created by Ed Ballington on 2/15/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsConstants.h"

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *enableSoundEffects;
@property (weak, nonatomic) IBOutlet UISwitch *enableBackgroundMusic;
@property (weak, nonatomic) IBOutlet UISwitch *useStopwatchTimer;
@property (weak, nonatomic) IBOutlet UISwitch *useSolveAssist;




@end
