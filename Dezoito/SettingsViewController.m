//
//  SettingsViewController.m
//  Dezoito
//
//  Created by Ed Ballington on 2/15/15.
//  Copyright (c) 2015 Ed Ballington. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Retrieve the saved settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Update the settings UI with the saved values
    [self.enableSoundEffects setOn:[defaults boolForKey:SOUND_EFFECTS_KEY] animated:NO];
    [self.enableBackgroundMusic setOn:[defaults boolForKey:BACKGROUND_MUSIC_KEY] animated:NO];
    [self.useStopwatchTimer setOn:[defaults boolForKey:STOPWATCH_KEY] animated:NO];
    [self.useSolveAssist setOn:[defaults boolForKey:SOLUTION_GUIDE_KEY] animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Save the settings to NSUserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:[self.enableSoundEffects isOn] forKey:SOUND_EFFECTS_KEY];
    [defaults setBool:[self.enableBackgroundMusic isOn] forKey:BACKGROUND_MUSIC_KEY];
    [defaults setBool:[self.useStopwatchTimer isOn] forKey:STOPWATCH_KEY];
    [defaults setBool:[self.useSolveAssist isOn] forKey:SOLUTION_GUIDE_KEY];
    
    [defaults synchronize];
    
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
