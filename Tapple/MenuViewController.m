//
//  MenuViewController.m
//  Tapple
//
//  Created by Jed on 02/10/2013.
//  Copyright (c) 2013 Jed. All rights reserved.
//

#import "MenuViewController.h"
#import <GameKit/GameKit.h>
#import "GCHelper.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)helpButtonPressed:(id)sender {
    UIAlertView *helpAlert = [[UIAlertView alloc]
                           initWithTitle:@"Help" message:@"Tap the apple and buy upgrades, creating an enormous apple industry. Then, try challenging your friends or doing some challenges to prove that you're the best apple guy, type thing!..."
                           delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [helpAlert show];
}

- (IBAction)hostMatch: (id) sender {
    [self performSegueWithIdentifier:@"menuToMultiplayerSegue" sender:self];
}
@end
