//
//  Myscene.h
//  ParticleSnowNum1
//
//  Created by Yongjia Liu on 14-3-6.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@interface Myscene : SKScene
@property SKLabelNode *myLabel;
-(void)setTemp:(int) h and:(int)w;
- (SKEmitterNode *) newExplosionSnow: (float)posX : (float) posy;
- (SKEmitterNode *) newExplosionRain: (float)posX : (float) posy;
@end
