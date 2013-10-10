//
//  ViewController.m
//  Tapple
//
//  Created by Jed on 21/09/2013.
//  Copyright (c) 2013 Jed. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+Rotate.h"
#import <QuartzCore/QuartzCore.h>
#import <GameKit/GameKit.h>

#define defaults [NSUserDefaults standardUserDefaults];

@interface ViewController ()

@property float duration;
@property NSMutableArray *taps;

@property NSTimer *perSecondTimer;
@property NSTimer *perSecondSave;
@property NSTimer *averageTimer;
@property NSTimer *gameCenterSubmit;
@property NSTimer *fallingBottlesTimer;

@property float applesAllTime;

@property float prevApplesPerSecond;
@property float prevApplesPerClick;

@property BOOL shakeMultiplier;
@property BOOL shakeMultiplierShort;
@property float multiplierVal;

@property(assign, nonatomic) int64_t value; //GK
@end

@implementation ViewController

@synthesize appleButton;

@synthesize scroll;
@synthesize pageControl;

@synthesize playerHas;

@synthesize totalApplesLabel;
@synthesize applesPerSecondLabel;

@synthesize totalApplesLabels;

@synthesize rotation;
@synthesize cider;
@synthesize flash;

@synthesize tapCount;

@synthesize totalApples;
@synthesize applesPerClick;
@synthesize applesPerSecond;

@synthesize priceFarmhand;
@synthesize priceTreeshaker;
@synthesize pricePlantation;
@synthesize priceTrucker;
@synthesize priceWarehouse;
@synthesize priceRecycler;
@synthesize priceLab;
@synthesize priceBot;
@synthesize priceZapplein;
@synthesize priceShip;
@synthesize priceFlux;
@synthesize priceAccel;

@synthesize buttonFarmhand;
@synthesize buttonTreeshaker;
@synthesize buttonPlantation;
@synthesize buttonTrucker;
@synthesize buttonWarehouse;
@synthesize buttonRecycler;
@synthesize buttonLab;
@synthesize buttonBot;
@synthesize buttonZapplein;
@synthesize buttonShip;
@synthesize buttonFlux;
@synthesize buttonAccel;

@synthesize totalFarmhand;
@synthesize totalTreeshaker;
@synthesize totalPlantation;
@synthesize totalTrucker;
@synthesize totalWarehouse;
@synthesize totalRecycler;
@synthesize totalLab;
@synthesize totalBot;
@synthesize totalZapplein;
@synthesize totalShip;
@synthesize totalFlux;
@synthesize totalAccel;

@synthesize secondsElapsed;
@synthesize averageTapsPerSecond;

@synthesize lockSwitch;
@synthesize lockLabel;

@synthesize farmhandAPS;
@synthesize treeshakerAPS;
@synthesize plantationAPS;
@synthesize truckerAPS;
@synthesize warehouseAPS;
@synthesize recyclerAPS;
@synthesize labAPS;
@synthesize botAPS;
@synthesize zappleinAPS;
@synthesize shipAPS;
@synthesize fluxAPS;
@synthesize accelAPS;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [rotation rotate360WithDuration:15 repeatCount:0];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"Appeared");
    
    [rotation resumeAnimations];
    
    self.shakeMultiplier = NO;
    self.shakeMultiplierShort = NO;
    
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
    scroll.contentSize = CGSizeMake(768 * 3, 1024); // 3 pages wide.
    
    self.taps = [NSMutableArray array];
    
    self.prevApplesPerSecond = 0;
    self.prevApplesPerClick = 0;
    
    applesPerClick = 0;
    
    applesPerClick = [[NSUserDefaults standardUserDefaults] floatForKey:@"applesPerClick"];
    totalApples = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalApples"];
    applesPerSecond = [[NSUserDefaults standardUserDefaults] floatForKey:@"applesPerSecond"];
    totalFarmhand = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalFarmhand"];
    priceFarmhand = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceFarmhand"];
    totalTreeshaker = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalTreeshaker"];
    priceTreeshaker = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceTreeshaker"];
    totalPlantation = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalPlantation"];
    pricePlantation = [[NSUserDefaults standardUserDefaults] floatForKey:@"pricePlantation"];
    totalTrucker = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalTrucker"];
    priceTrucker = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceTrucker"];
    totalWarehouse = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalWarehouse"];
    priceWarehouse = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceWarehouse"];
    totalRecycler = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalRecycler"];
    priceRecycler = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceRecycler"];
    totalLab = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalLab"];
    priceLab = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceLab"];
    totalBot = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalBot"];
    priceBot = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceBot"];
    totalShip = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalShip"];
    priceShip = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceShip"];
    totalShip = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalShip"];
    priceZapplein = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceZapplein"];
    totalZapplein = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalZapplein"];
    priceFlux = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceFlux"];
    totalFlux = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalFlux"];
    totalAccel = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalAccel"];
    priceAccel = [[NSUserDefaults standardUserDefaults] floatForKey:@"priceAccel"];
    NSLog(@"Loaded");
    
    
    if(applesPerClick == 0) {
        NSLog(@"Callled");
        totalApples = 0;
        applesPerSecond = 0;
        applesPerClick = 1;
        priceFarmhand = 5;
        priceTreeshaker = 15;
        pricePlantation = 85;
        priceTrucker = 210;
        priceWarehouse = 1010;
        priceRecycler = 5035;
        priceLab = 25000;
        priceBot = 115000;
        priceZapplein = 123456789;
        priceShip = 1234567;
        priceFlux = 123456789123;
        priceAccel = 999000000000000;
        
        farmhandAPS = 0.2;
        treeshakerAPS = 1;
        plantationAPS = 3;
        truckerAPS = 7;
        warehouseAPS = 15;
        recyclerAPS = 35;
        labAPS = 100;
        botAPS = 2500;
        zappleinAPS = 10000;
        shipAPS = 110000;
        fluxAPS = 1111111;
        accelAPS = 9999999;
    }
    
    //    totalApples = 0;
    //    applesPerSecond = 0;
    //    applesPerClick = 1;
    //    priceFarmhand = 5;
    //    priceTreeshaker = 15;
    //    pricePlantation = 85;
    //    priceTrucker = 210;
    //    priceWarehouse = 1010;
    //    priceRecycler = 5035;
    //    priceLab = 25000;
    //    priceBot = 115000;
    //    priceZapplein = 123456789;
    //    priceShip = 1234567;
    //    priceFlux = 123456789123;
    //    priceAccel = 999000000000000;
    //
    farmhandAPS = 0.2;
    treeshakerAPS = 1;
    plantationAPS = 5;
    truckerAPS = 13;
    warehouseAPS = 25;
    recyclerAPS = 75;
    labAPS = 210;
    botAPS = 2500;
    zappleinAPS = 20000;
    shipAPS = 110000;
    fluxAPS = 111111111;
    accelAPS = 9999999999;
    //
    //    totalFarmhand = 0;
    //    totalTreeshaker = 0;
    //    totalPlantation = 0;
    //    totalTrucker = 0;
    //    totalWarehouse = 0;
    //    totalRecycler = 0;
    //    totalLab = 0;
    //    totalBot = 0;
    //    totalZapplein = 0;
    //    totalShip = 0;
    //    totalFlux = 0;
    //    totalAccel = 0;
    
    
    self.perSecondTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target:self selector:@selector(addApplesPerSecond:) userInfo: nil repeats:YES]; //setting the timer interval
    self.perSecondSave = [NSTimer scheduledTimerWithTimeInterval: 0.5 target:self selector:@selector(save) userInfo: nil repeats:YES]; //setting the timer interval
    self.gameCenterSubmit = [NSTimer scheduledTimerWithTimeInterval: 60 target:self selector:@selector(updateScore) userInfo: nil repeats:YES]; //setting the timer interval
    
    NSLog(@"Loaded");
    
    [self setText:[NSString stringWithFormat:@"%.1f", totalApples] withExistingAttributesInLabel:self.totalApplesLabel];
    [self setText:[NSString stringWithFormat:@"%.1f per second", applesPerSecond] withExistingAttributesInLabel:self.applesPerSecondLabel];
    
    [scroll setContentOffset:CGPointMake(768, 0)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appplicationIsActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnteredForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
//    [self alphaChange];
//    [NSTimer scheduledTimerWithTimeInterval: 30.0 target:self selector:@selector(alphaChange) userInfo:nil repeats:YES];
    
    secondsElapsed = 0;
    averageTapsPerSecond = 0;
    
    [self setText:[NSString stringWithFormat:@"%0f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.lastObject];
    [self setText:[NSString stringWithFormat:@"%0f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.firstObject];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceFarmhand] withExistingAttributesInLabel:self.priceFarmhandLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalFarmhand] withExistingAttributesInLabel:self.farmhandLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceTreeshaker] withExistingAttributesInLabel:self.priceTreeshakerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalTreeshaker] withExistingAttributesInLabel:self.treeshakerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", pricePlantation] withExistingAttributesInLabel:self.pricePlantationLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalPlantation] withExistingAttributesInLabel:self.PlantationLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceTrucker] withExistingAttributesInLabel:self.priceTruckerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalTrucker] withExistingAttributesInLabel:self.truckerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceWarehouse] withExistingAttributesInLabel:self.priceWarehouseLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalWarehouse] withExistingAttributesInLabel:self.WarehouseLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceRecycler] withExistingAttributesInLabel:self.priceRecyclerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalRecycler] withExistingAttributesInLabel:self.recyclerLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceLab] withExistingAttributesInLabel:self.priceLabLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalLab] withExistingAttributesInLabel:self.labLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceBot] withExistingAttributesInLabel:self.priceBotLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalBot] withExistingAttributesInLabel:self.botLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceShip] withExistingAttributesInLabel:self.priceShipLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalShip] withExistingAttributesInLabel:self.shipLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceZapplein] withExistingAttributesInLabel:self.priceZappleinLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalZapplein] withExistingAttributesInLabel:self.ZappleinLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceFlux] withExistingAttributesInLabel:self.priceFluxLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalFlux] withExistingAttributesInLabel:self.fluxLabel];
    [self setText:[NSString stringWithFormat:@"%0.f apples", priceAccel] withExistingAttributesInLabel:self.priceAccelLabel];
    [self setText:[NSString stringWithFormat:@"%0.f", totalAccel] withExistingAttributesInLabel:self.accelLabel];
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.perSecondSave invalidate];
    [self.perSecondTimer invalidate];
    [self.averageTimer invalidate];
    [self.fallingBottlesTimer invalidate];
    [rotation pauseAnimations];
    [self becomeFirstResponder];
}

-(void)save {
    [[NSUserDefaults standardUserDefaults] setFloat:totalApples forKey:@"totalApples"];
    if(self.shakeMultiplier == NO) {
        [[NSUserDefaults standardUserDefaults] setFloat:applesPerSecond forKey:@"applesPerSecond"];
        [[NSUserDefaults standardUserDefaults] setFloat:applesPerClick forKey:@"applesPerClick"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalFarmhand forKey:@"totalFarmhand"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceFarmhand forKey:@"priceFarmhand"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalTreeshaker forKey:@"totalTreeshaker"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceTreeshaker forKey:@"priceTreeshaker"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalPlantation forKey:@"totalPlantation"];
        [[NSUserDefaults standardUserDefaults] setFloat:pricePlantation forKey:@"pricePlantation"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalTrucker forKey:@"totalTrucker"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceTrucker forKey:@"priceTrucker"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalWarehouse forKey:@"totalWarehouse"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceWarehouse forKey:@"priceWarehouse"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalRecycler forKey:@"totalRecycler"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceRecycler forKey:@"priceRecycler"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalLab forKey:@"totalLab"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceLab forKey:@"priceLab"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalBot forKey:@"totalBot"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceBot forKey:@"priceBot"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalShip forKey:@"totalShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceShip forKey:@"priceShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalShip forKey:@"totalShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceZapplein forKey:@"priceZapplein"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalZapplein forKey:@"totalZapplein"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceFlux forKey:@"priceFlux"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalFlux forKey:@"totalFlux"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalAccel forKey:@"totalAccel"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceAccel forKey:@"priceAccel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Saved!");
        NSLog(@"%f", totalApples);
        totalApples = [[NSUserDefaults standardUserDefaults] floatForKey:@"totalApples"];
        NSLog(@"%f", totalApples);
        [self fallingBottles];
    }
}

-(void)alphaChange {
    [UIImageView animateWithDuration:10.0 animations:^(void) {
        rotation.alpha = 0.3;
        NSLog(@"Out");
    }];
    [self performSelector:@selector(alphaChange2) withObject:self afterDelay:10.0 ];
}

-(void)alphaChange2 {
    [UIImageView animateWithDuration:10.0 animations:^(void) {
        rotation.alpha = 1.0;
        NSLog(@"IN");
    }];
}

- (void)setText:(NSString *)text withExistingAttributesInLabel:(UILabel *)label {
    
    // Check label has existing text
    if ([label.attributedText length]) {
        
        // Extract attributes
        NSDictionary *attributes = [(NSAttributedString *)label.attributedText attributesAtIndex:0 effectiveRange:NULL];
        
        // Set new text with extracted attributes
        label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
        
    }
    
}

- (void)appplicationIsActive:(NSNotification *)notification {
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(addApplesPerSecond:) userInfo:nil repeats:YES];
}

- (void)applicationEnteredForeground:(NSNotification *)notification {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(save) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addApplesPerSecond:(NSTimer *) perSecondTimer {
    if(self.shakeMultiplierShort == NO) {
        self.prevApplesPerClick = applesPerClick;
        self.prevApplesPerSecond = applesPerSecond;
    }
    
    //[self ReportScore:totalApples forLeaderboardID:@"totalApples"];
    self.applesAllTime += (applesPerSecond/10);
    totalApples += (applesPerSecond / 10);
    [self setText:[NSString stringWithFormat:@"%0.1f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.lastObject];
    [self setText:[NSString stringWithFormat:@"%0.1f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.firstObject];
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    if (state == UIApplicationStateBackground || state == UIApplicationStateInactive)
    {
        //Do checking here.
        [perSecondTimer invalidate];
        perSecondTimer = nil;

    }
    
    //checking if can afford
    [self canAfford:priceFarmhand button:buttonFarmhand];
    [self canAfford:priceTreeshaker button:buttonTreeshaker];
    [self canAfford:pricePlantation button:buttonPlantation];
    [self canAfford:priceTrucker button:buttonTrucker];
    [self canAfford:priceWarehouse button:buttonWarehouse];
    [self canAfford:priceRecycler button:buttonRecycler];
    [self canAfford:priceLab button:buttonLab];
    [self canAfford:priceBot button:buttonBot];
    [self canAfford:priceZapplein button:buttonZapplein];
    [self canAfford:priceShip button:buttonShip];
    [self canAfford:priceFlux button:buttonFlux];
    [self canAfford:priceAccel button:buttonAccel];
}

-(BOOL)playerHas:(float) f {
    if(self.shakeMultiplierShort == YES) {
        return FALSE;
    } else if(totalApples >= f) {
        return TRUE;
    } else {
        return FALSE;
    }
}

-(void)canAfford:(float) f button:(UIButton*)button {
    if(self.shakeMultiplierShort == YES) {
        button.backgroundColor = [UIColor blackColor];
    } else if([self playerHas:(f)] == YES) {
        button.backgroundColor = nil;
    } else {
        button.backgroundColor = [UIColor blackColor];
    }
}

-(IBAction)addApplesPerClick {
    totalApples += applesPerClick;
    self.applesAllTime += applesPerClick;
    
    tapCount++;
    
    [self.appleButton.layer removeAllAnimations];
    CGPoint centerPoint = appleButton.center;
    [UIView animateWithDuration:0.1 animations:^{
        appleButton.frame = CGRectMake(0, 0, 600, 600);
    }];
    appleButton.center = centerPoint;
    
//    CGPoint centerPoint = appleButton.center;
//    appleButton.frame = CGRectMake(0, 0, 600, 600);
//    appleButton.center = centerPoint;
    
    [self setText:[NSString stringWithFormat:@"%0.1f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.lastObject];
    [self setText:[NSString stringWithFormat:@"%0.1f apples", totalApples] withExistingAttributesInLabel:self.totalApplesLabels.firstObject];
    
    [self setPosOfCider];
    
    int x = arc4random() % 280;
    int y = arc4random() % 200;
    int xpoint = x+1045;
    int ypoint = y+400;
    int secondY = ypoint - 200;
    
    UILabel *plusSymbol = [[UILabel alloc]initWithFrame:(CGRectMake(xpoint, ypoint, 330, 326))];
    plusSymbol.textColor = [UIColor whiteColor];
    [scroll addSubview:(plusSymbol)];
    plusSymbol.text = [NSString stringWithFormat:@"+%.f", applesPerClick];
    
    [UIView animateWithDuration:1.5 animations:^{
                         // set the alpha to 1 for a fade in (maybe add another block to do that at a different speed
                         plusSymbol.frame = CGRectMake(xpoint, secondY, 330, 326); // set the destination frame
                         plusSymbol.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [plusSymbol removeFromSuperview];
                     }];
    
    [self.taps addObject:[NSDate date]];
    // if less than two taps, no average speed
    
    if ([self.taps count] < 9)
        return;
    
    // only average the last three taps
    
    if ([self.taps count] > 11)
        [self.taps removeObjectAtIndex:0];
    
    // now calculate the average taps per second of the last three taps
    
    NSDate *start = self.taps[0];
    NSDate *end   = [self.taps lastObject];
    
    self.averageTapsPerSecond = [self.taps count] / [end timeIntervalSinceDate:start];
    cider.alpha = 0.8;
    
}

-(void)buyItem:(float)price total:(float) total itemNo:(int) i {
    if([self playerHas:(price)] == YES) {
        totalApples -= price;
        switch(i) {
            case 1:
                priceFarmhand = priceFarmhand * 1.27;
                totalFarmhand++;
                applesPerSecond += farmhandAPS;
                break;
            case 2:
                priceTreeshaker = priceTreeshaker * 1.27;
                totalTreeshaker++;
                applesPerSecond += treeshakerAPS;
                break;
            case 3:
                pricePlantation = pricePlantation * 1.27;
                totalPlantation++;
                applesPerSecond += plantationAPS;
                break;
            case 4:
                priceTrucker = priceTrucker * 1.27;
                totalTrucker++;
                applesPerSecond += truckerAPS;
                break;
            case 5:
                priceWarehouse = priceWarehouse * 1.27;
                totalWarehouse++;
                applesPerSecond += warehouseAPS;
                break;
            case 6:
                priceRecycler = priceRecycler * 1.27;
                totalRecycler++;
                applesPerSecond += recyclerAPS;
                break;
            case 7:
                priceLab = priceLab * 1.27;
                totalLab++;
                applesPerSecond += labAPS;
                break;
            case 8:
                priceBot = priceBot * 1.27;
                totalBot++;
                applesPerSecond += botAPS;
                break;
            case 9:
                priceZapplein = priceZapplein * 1.27;
                totalZapplein++;
                applesPerSecond += zappleinAPS;
                break;
            case 10:
                priceShip = priceShip * 1.27;
                totalShip++;
                applesPerSecond += shipAPS;
                break;
            case 11:
                priceFlux = priceFlux * 1.27;
                totalFlux++;
                applesPerSecond += fluxAPS;
                break;
            case 12:
                priceAccel = priceAccel * 1.27;
                totalAccel++;
                applesPerSecond += accelAPS;
                break;
        }
        [self setText:[NSString stringWithFormat:@"%.1f per second", applesPerSecond] withExistingAttributesInLabel:self.applesPerSecondLabel];
        
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceFarmhand] withExistingAttributesInLabel:self.priceFarmhandLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalFarmhand] withExistingAttributesInLabel:self.farmhandLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceTreeshaker] withExistingAttributesInLabel:self.priceTreeshakerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalTreeshaker] withExistingAttributesInLabel:self.treeshakerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", pricePlantation] withExistingAttributesInLabel:self.pricePlantationLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalPlantation] withExistingAttributesInLabel:self.PlantationLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceTrucker] withExistingAttributesInLabel:self.priceTruckerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalTrucker] withExistingAttributesInLabel:self.truckerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceWarehouse] withExistingAttributesInLabel:self.priceWarehouseLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalWarehouse] withExistingAttributesInLabel:self.WarehouseLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceRecycler] withExistingAttributesInLabel:self.priceRecyclerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalRecycler] withExistingAttributesInLabel:self.recyclerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceLab] withExistingAttributesInLabel:self.priceLabLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalLab] withExistingAttributesInLabel:self.labLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceBot] withExistingAttributesInLabel:self.priceBotLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalBot] withExistingAttributesInLabel:self.botLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceShip] withExistingAttributesInLabel:self.priceShipLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalShip] withExistingAttributesInLabel:self.shipLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceZapplein] withExistingAttributesInLabel:self.priceZappleinLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalZapplein] withExistingAttributesInLabel:self.ZappleinLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceFlux] withExistingAttributesInLabel:self.priceFluxLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalFlux] withExistingAttributesInLabel:self.fluxLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceAccel] withExistingAttributesInLabel:self.priceAccelLabel];
        [self setText:[NSString stringWithFormat:@"%0.f", totalAccel] withExistingAttributesInLabel:self.accelLabel];
    }
}

-(IBAction)buyFarmhand {
    [self buyItem:(priceFarmhand) total:(totalFarmhand) itemNo:(1)];
}

-(IBAction)buyTreeshaker {
    [self buyItem:(priceTreeshaker) total:(totalTreeshaker) itemNo:(2)];
}

-(IBAction)buyPlantation {
    [self buyItem:(pricePlantation) total:(totalPlantation) itemNo:(3)];
}

-(IBAction)buyTrucker {
    [self buyItem:(priceTrucker) total:(totalTrucker) itemNo:(4)];
}

-(IBAction)buyWarehouse {
    [self buyItem:(priceWarehouse) total:(totalWarehouse) itemNo:(5)];
}

-(IBAction)buyRecyler {
    [self buyItem:(priceRecycler) total:(totalRecycler) itemNo:(6)];
}

-(IBAction)buyLab {
    [self buyItem:(priceLab) total:(totalLab) itemNo:(7)];
}

-(IBAction)buyBot {
    [self buyItem:(priceBot) total:(totalBot) itemNo:(8)];
}

-(IBAction)buyZapplein {
    [self buyItem:(priceZapplein) total:(totalZapplein) itemNo:(9)];
}

-(IBAction)buyShip {
    [self buyItem:(priceShip) total:(totalShip) itemNo:(10)];
}

-(IBAction)buyFlux {
    [self buyItem:(priceFlux) total:(totalFlux) itemNo:(11)];
}

-(IBAction)buyAccel {
    [self buyItem:(priceAccel) total:(totalAccel) itemNo:(13)];
}



-(void)fallingBottles {
    
    int x = arc4random() % 600;
    int y = arc4random() % 50;
    float rotatedAmount = arc4random() % 200;
    
    
    int pointx = 0;
    int pointy = 0;
    int secondy = 0;
    float rotatedAmountInRadians = (rotatedAmount/100) * M_PI;
    
    pointx = x + 800;
    pointy = y - 300;
    secondy = y + 1300;
    
    
    UIImageView *fallingBottle = [[UIImageView alloc]initWithFrame:(CGRectMake(pointx, pointy, 100, 100))];
    [scroll insertSubview:fallingBottle belowSubview:rotation];
    fallingBottle.image = [UIImage imageNamed:@"fallingapple.png"];
    fallingBottle.alpha = 0.5;
    fallingBottle.transform = CGAffineTransformMakeRotation(rotatedAmountInRadians);
    
    [UIView animateWithDuration:7.5 animations:^{
        // set the alpha to 1 for a fade in (maybe add another block to do that at a different speed
        fallingBottle.center = CGPointMake(pointx, secondy); // set the destination frame
    }
                     completion:^(BOOL finished) {
                         
                         [fallingBottle removeFromSuperview];
                     }];
}


-(void)setPosOfCider {
    CALayer *presentationLayer = self.cider.layer.presentationLayer;
    [self.cider.layer removeAllAnimations];
    self.cider.frame = presentationLayer.frame;
    
    [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.cider.frame = CGRectMake(768, 950 - averageTapsPerSecond * 50, 1500, 1024);
        }
                     completion:^(BOOL finished) {
                        
                     }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        if(self.shakeMultiplier == NO) {
            // Do your thing after shaking device
            self.shakeMultiplier = YES;
            self.shakeMultiplierShort = YES;
            
            self.multiplierVal = self.averageTapsPerSecond / 2;
            
            [UIView animateWithDuration:3.0 animations:^{
                self.cider.alpha = 0;
                self.cider.frame = CGRectMake(768, 1024, 768, 1024);
            }];
            
            applesPerSecond = applesPerSecond * self.multiplierVal;
            applesPerClick = applesPerClick * self.multiplierVal;
            
            [self setText:[NSString stringWithFormat:@"%0.1f per second", applesPerSecond] withExistingAttributesInLabel:self.applesPerSecondLabel];
            
            [NSTimer scheduledTimerWithTimeInterval:self.averageTapsPerSecond * 3 target:self selector:@selector(resetValues) userInfo:nil repeats:NO];
            
            flash.alpha = 0.8;
            
            self.cannotPurchase.hidden = NO;
            
            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(removeFlash) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(resetMultiplierBool) userInfo:nil repeats:NO];
        }
    }
}

-(void)resetValues {

    applesPerSecond = self.prevApplesPerSecond;
    applesPerClick = self.prevApplesPerClick;
    
    self.shakeMultiplierShort = NO;
    
    [self setText:[NSString stringWithFormat:@"%0.1f per second", applesPerSecond] withExistingAttributesInLabel:self.applesPerSecondLabel];
    
    flash.alpha = 0.8;
    
    self.cannotPurchase.hidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(removeFlash) userInfo:nil repeats:NO];
}

-(void)removeFlash {
    flash.alpha = 0;
}

-(IBAction)valueChanged:(id)sender {
    if(lockSwitch.isOn == YES) {
        scroll.scrollEnabled = NO;
        [self setText:[NSString stringWithFormat:@"Locked"] withExistingAttributesInLabel:self.lockLabel];
    } else {
        scroll.scrollEnabled = YES;
        [self setText:[NSString stringWithFormat:@"Unlocked"] withExistingAttributesInLabel:self.lockLabel];
    }
}

-(IBAction)appleTappedDown {
//    
//    CGPoint centerPoint = appleButton.center;
//    appleButton.frame = CGRectMake(0, 0, 550, 550);
//    appleButton.center = centerPoint;
//    [self.appleButton.layer removeAllAnimations];
    CGPoint centerPoint = appleButton.center;
    [UIView animateWithDuration:0.1 animations:^{
        appleButton.frame = CGRectMake(0, 0, 550, 550);
    }];
    appleButton.center = centerPoint;
}

-(IBAction)showActionSheet:(id)sender {
    NSLog(@"Pressed");
    UIActionSheet *resetConfirm = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to reset? (Everything will be lost)"
                                                              delegate:self cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:@"Yes, I want to reset"
                                                     otherButtonTitles:nil];
   // resetConfirm.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [resetConfirm showInView:[UIApplication sharedApplication].keyWindow];
}
                                
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        totalApples = 0;
        applesPerSecond = 0;
        applesPerClick = 1;
        priceFarmhand = 5;
        priceTreeshaker = 15;
        pricePlantation = 85;
        priceTrucker = 210;
        priceWarehouse = 1010;
        priceRecycler = 5035;
        priceLab = 25000;
        priceBot = 115000;
        priceZapplein = 123456789;
        priceShip = 1234567;
        priceFlux = 123456789123;
        priceAccel = 999000000000000;
        
        totalFarmhand = 0;
        totalTreeshaker = 0;
        totalPlantation = 0;
        totalTrucker = 0;
        totalWarehouse = 0;
        totalRecycler = 0;
        totalLab = 0;
        totalBot = 0;
        totalZapplein = 0;
        totalShip = 0;
        totalFlux = 0;
        totalAccel = 0;
        
        [[NSUserDefaults standardUserDefaults] setFloat:totalApples forKey:@"totalApples"];
        [[NSUserDefaults standardUserDefaults] setFloat:applesPerSecond forKey:@"applesPerSecond"];
        [[NSUserDefaults standardUserDefaults] setFloat:applesPerClick forKey:@"applesPerClick"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalFarmhand forKey:@"totalApples"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceFarmhand forKey:@"priceFarmhand"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalTreeshaker forKey:@"totalTreeshaker"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceTreeshaker forKey:@"priceTreeshaker"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalPlantation forKey:@"totalPlantation"];
        [[NSUserDefaults standardUserDefaults] setFloat:pricePlantation forKey:@"pricePlantation"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalTrucker forKey:@"totalTrucker"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceTrucker forKey:@"priceTrucker"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalWarehouse forKey:@"totalWarehouse"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceWarehouse forKey:@"priceWarehouse"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalRecycler forKey:@"totalRecycler"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceRecycler forKey:@"priceRecycler"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalLab forKey:@"totalLab"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceLab forKey:@"priceLab"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalBot forKey:@"totalBot"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceBot forKey:@"priceBot"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalShip forKey:@"totalShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceShip forKey:@"priceShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalShip forKey:@"totalShip"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceZapplein forKey:@"priceZapplein"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalZapplein forKey:@"totalZapplein"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceFlux forKey:@"priceFlux"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalFlux forKey:@"totalFlux"];
        [[NSUserDefaults standardUserDefaults] setFloat:totalAccel forKey:@"totalAccel"];
        [[NSUserDefaults standardUserDefaults] setFloat:priceAccel forKey:@"priceAccel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self setText:[NSString stringWithFormat:@"%.1f per second", applesPerSecond] withExistingAttributesInLabel:self.applesPerSecondLabel];
        
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceFarmhand] withExistingAttributesInLabel:self.priceFarmhandLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalFarmhand] withExistingAttributesInLabel:self.farmhandLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceTreeshaker] withExistingAttributesInLabel:self.priceTreeshakerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalTreeshaker] withExistingAttributesInLabel:self.treeshakerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", pricePlantation] withExistingAttributesInLabel:self.pricePlantationLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalPlantation] withExistingAttributesInLabel:self.PlantationLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceTrucker] withExistingAttributesInLabel:self.priceTruckerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalTrucker] withExistingAttributesInLabel:self.truckerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceWarehouse] withExistingAttributesInLabel:self.priceWarehouseLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalWarehouse] withExistingAttributesInLabel:self.WarehouseLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceRecycler] withExistingAttributesInLabel:self.priceRecyclerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalRecycler] withExistingAttributesInLabel:self.recyclerLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceLab] withExistingAttributesInLabel:self.priceLabLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalLab] withExistingAttributesInLabel:self.labLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceBot] withExistingAttributesInLabel:self.priceBotLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalBot] withExistingAttributesInLabel:self.botLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceShip] withExistingAttributesInLabel:self.priceShipLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalShip] withExistingAttributesInLabel:self.shipLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceZapplein] withExistingAttributesInLabel:self.priceZappleinLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalZapplein] withExistingAttributesInLabel:self.ZappleinLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceFlux] withExistingAttributesInLabel:self.priceFluxLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalFlux] withExistingAttributesInLabel:self.fluxLabel];
        [self setText:[NSString stringWithFormat:@"%0.f apples", priceAccel] withExistingAttributesInLabel:self.priceAccelLabel];
        [self setText:[NSString stringWithFormat:@"%0.f owned", totalAccel] withExistingAttributesInLabel:self.accelLabel];
    }
}

-(void)resetMultiplierBool {
    self.shakeMultiplier = NO;
}

-(IBAction)preventMultiplierGlitching {
    NSLog(@"%f", self.prevApplesPerSecond);
    applesPerClick = self.prevApplesPerClick;
    applesPerSecond = self.prevApplesPerSecond;
}

- (void) forceReportScore: (int64_t) score forLeaderboardID: (NSString*) category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:category];
    scoreReporter.shouldSetDefaultLeaderboard = YES;
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil message:@"Score Updated Succesfully"
                              delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }];
}

- (void) reportScore: (int64_t) score forLeaderboardID: (NSString*) category
{
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:category];
    scoreReporter.shouldSetDefaultLeaderboard = YES;
    scoreReporter.value = score;
    scoreReporter.context = 0;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
    }];
}


- (void) showGameCenter
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}

-(IBAction)openGameCenter {
    [self showGameCenter];
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)forceSubmitScore:(id)sender {
    [self forceReportScore:self.applesAllTime forLeaderboardID:@"totalApples"];
}

-(void)updateScore {
    [self reportScore:self.applesAllTime forLeaderboardID:@"totalApples"];
}



@end
