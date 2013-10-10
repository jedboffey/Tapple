//
//  ViewController.h
//  Tapple
//
//  Created by Jed on 21/09/2013.
//  Copyright (c) 2013 Jed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate> {
    float totalApples;
    float applesPerClick;
    float applesPerSecond;
    
    BOOL playerHas;
    
    float priceTreeshaker;
    float priceFarmhand;
    float pricePlantation;
    float priceTrucker;
    float priceWarehouse;
    float priceRecycler;
    float priceLab;
    float priceBot;
    float priceZapplein;
    float priceShip;
    float priceFlux;
    float priceAccel;
    
    float totalFarmhand;
    float totalTreeshaker;
    float totalPlantation;
    float totalTrucker;
    float totalWarehouse;
    float totalRecycler;
    float totalLab;
    float totalBot;
    float totalZapplein;
    float totalShip;
    float totalFlux;
    float totalAccel;
    
    float tapCountInLastSecond;
    float averageTapsPerSecond;
    float secondsElapsed;
    float tapCount;
    
    float farmhandAPS;
    float treeshakerAPS;
    float plantationAPS;
    float truckerAPS;
    float warehouseAPS;
    float recyclerAPS;
    float labAPS;
    float botAPS;
    float zappleinAPS;
    float shipAPS;
    float fluxAPS;
    float accelAPS;
}

@property(strong,nonatomic) IBOutlet UIImageView *appleButton;

@property(strong,nonatomic) IBOutlet UIScrollView *scroll;
@property(strong,nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong,nonatomic) IBOutlet UILabel *totalApplesLabel;
@property(strong,nonatomic) IBOutlet UILabel *applesPerSecondLabel;

@property(strong,nonatomic) IBOutlet UILabel *priceFarmhandLabel;
@property(strong,nonatomic) IBOutlet UILabel *farmhandLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceTreeshakerLabel;
@property(strong,nonatomic) IBOutlet UILabel *treeshakerLabel;
@property(strong,nonatomic) IBOutlet UILabel *pricePlantationLabel;
@property(strong,nonatomic) IBOutlet UILabel *PlantationLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceTruckerLabel;
@property(strong,nonatomic) IBOutlet UILabel *truckerLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceWarehouseLabel;
@property(strong,nonatomic) IBOutlet UILabel *WarehouseLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceRecyclerLabel;
@property(strong,nonatomic) IBOutlet UILabel *recyclerLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceLabLabel;
@property(strong,nonatomic) IBOutlet UILabel *labLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceBotLabel;
@property(strong,nonatomic) IBOutlet UILabel *botLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceZappleinLabel;
@property(strong,nonatomic) IBOutlet UILabel *ZappleinLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceShipLabel;
@property(strong,nonatomic) IBOutlet UILabel *shipLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceFluxLabel;
@property(strong,nonatomic) IBOutlet UILabel *fluxLabel;
@property(strong,nonatomic) IBOutlet UILabel *priceAccelLabel;
@property(strong,nonatomic) IBOutlet UILabel *accelLabel;

@property(strong,nonatomic) IBOutlet UILabel *cannotPurchase;

@property(nonatomic,strong) IBOutletCollection(UILabel) NSArray *totalApplesLabels;

@property(nonatomic,strong) IBOutlet UIImageView *rotation;
@property(nonatomic,strong) IBOutlet UIImageView *cider;
@property(nonatomic,strong) IBOutlet UIView *flash;

@property(nonatomic, strong) IBOutlet UIButton *buttonFarmhand;
@property(nonatomic, strong) IBOutlet UIButton *buttonTreeshaker;
@property(nonatomic, strong) IBOutlet UIButton *buttonPlantation;
@property(nonatomic, strong) IBOutlet UIButton *buttonTrucker;
@property(nonatomic, strong) IBOutlet UIButton *buttonWarehouse;
@property(nonatomic, strong) IBOutlet UIButton *buttonRecycler;
@property(nonatomic, strong) IBOutlet UIButton *buttonLab;
@property(nonatomic, strong) IBOutlet UIButton *buttonBot;
@property(nonatomic, strong) IBOutlet UIButton *buttonZapplein;
@property(nonatomic, strong) IBOutlet UIButton *buttonShip;
@property(nonatomic, strong) IBOutlet UIButton *buttonFlux;
@property(nonatomic, strong) IBOutlet UIButton *buttonAccel;

@property(nonatomic, strong) IBOutlet UISwitch *lockSwitch;
@property(nonatomic, strong) IBOutlet UILabel *lockLabel;

@property float totalApples;
@property float applesPerClick;
@property float applesPerSecond;

@property BOOL playerHas;

@property float priceTreeshaker;
@property float priceFarmhand;
@property float pricePlantation;
@property float priceTrucker;
@property float priceWarehouse;
@property float priceRecycler;
@property float priceLab;
@property float priceBot;
@property float priceZapplein;
@property float priceShip;
@property float priceFlux;
@property float priceAccel;

@property float totalFarmhand;
@property float totalTreeshaker;
@property float totalPlantation;
@property float totalTrucker;
@property float totalWarehouse;
@property float totalRecycler;
@property float totalLab;
@property float totalBot;
@property float totalZapplein;
@property float totalShip;
@property float totalFlux;
@property float totalAccel;

@property float secondsElapsed;
@property float tapCount;
@property float averageTapsPerSecond;

@property float farmhandAPS;
@property float treeshakerAPS;
@property float plantationAPS;
@property float truckerAPS;
@property float warehouseAPS;
@property float recyclerAPS;
@property float labAPS;
@property float botAPS;
@property float zappleinAPS;
@property float shipAPS;
@property float fluxAPS;
@property float accelAPS;

//@property NSMutableArray *clicksPerSecond;

@end
