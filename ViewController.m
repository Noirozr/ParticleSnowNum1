//
//  ViewController.m
//  ParticleSnowNum1
//
//  Created by Yongjia Liu on 14-3-6.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//


#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"


@interface ViewController ()
{
    float temp;
}
@property SKView *skview;
@property UISlider *temperature;
@property Myscene *scene;
@property SKEmitterNode *node;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 100)];
    self.skview=[[SKView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.temperature=[[UISlider alloc]initWithFrame:CGRectMake(30, 20, self.view.bounds.size.width-60, 30)];
    self.temperature.minimumValue=-20.0;
    self.temperature.maximumValue=35.0;
    self.temperature.value=10;
    temp=self.temperature.value;
    [self.temperature setBackgroundColor:[UIColor clearColor]];
    //[self.skview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bkground.png"]]];
    [self.view addSubview:self.skview];
    [self.skview addSubview:self.temperature];
    //self.skview.showsFPS = YES;
    //self.skview.showsNodeCount = YES;
    self.scene = [Myscene sceneWithSize:self.skview.bounds.size];
    
    
    
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene setTemp:self.temperature.value/2 and:self.temperature.value];
    self.node=[self.scene newExplosionRain:self.scene.frame.size.width/2: self.scene.frame.size.height];
    [self.scene addChild:self.node];
    [self.skview presentScene:self.scene];
    
    [self.temperature addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    label.text=@"test for clear color";
    [self.view addSubview:label];
    //[self.scene addChild:[self.scene newExplosion:self.scene.frame.size.width/2: self.scene.frame.size.height]];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void) sliderValueChanged:(id)sender{
    UISlider* control = (UISlider*)sender;
    if(control == self.temperature){
        temp = control.value;
        SKEmitterNode *node=self.node;
        if (temp>=0) {
            [self.scene setTemp:temp*0.75 and:temp*1.5];
            self.node=[self.scene newExplosionRain:self.scene.frame.size.width/2: self.scene.frame.size.height];

        }else{
            [self.scene setTemp:-temp*0.75 and:-temp*1.5];
            self.node=[self.scene newExplosionSnow:self.scene.frame.size.width/2: self.scene.frame.size.height+50];

        }
        
        //[self.node removeAllChildren];
        [self.scene addChild:self.node];
        node.particleLifetime=0.0;
        NSString *string=[NSString stringWithFormat:@"%.0f ℉/ %.0f ℃ ",9*temp/5+32,temp];
        self.scene.myLabel.text=string;
        //CAAnimation 先渐渐透明，动画结束后移除
        //[node removeFromParent];
        
       
        
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

