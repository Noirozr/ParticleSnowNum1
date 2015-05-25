//
//  Myscene.m
//  ParticleSnowNum1
//
//  Created by Yongjia Liu on 14-3-6.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import "Myscene.h"

@implementation Myscene
{
    float height,width;
}
@synthesize myLabel;
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //self.backgroundColor = [SKColor colorWithRed:0.43 green:0.29 blue:0.61 alpha:1.0];
        UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [slider setBackgroundColor:[UIColor clearColor]];
        NSMutableArray *colorArray = [@[[UIColor colorWithRed:0.07 green:0.15 blue:0.25 alpha:1],[UIColor colorWithRed:0.15 green:0.54 blue:0.65 alpha:1],[UIColor colorWithRed:0.51 green:0.78 blue:0.83 alpha:1]] mutableCopy];
        UIImage *backImage = [self getImageFromColors:colorArray];
        SKTexture *texture=[SKTexture textureWithImage:backImage];
        SKSpriteNode *sprite=[SKSpriteNode spriteNodeWithTexture:texture];
        sprite.size=CGSizeMake(650, 1200);
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        myLabel.text = @"Especially";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:sprite];
        [self addChild:myLabel];
        //[myLabel runAction:[SKAction fadeOutWithDuration:1.0]];
        //[self addChild:[self newExplosion:self.frame.size.width/2: self.frame.size.height]];
        //[self addChild:[self newExplosion:self.frame.size.width/2:self.frame.size.height]];
    }
    return self;
}
- (SKEmitterNode *) newExplosionSnow: (float)posX : (float) posy
{
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
    emitter.particlePosition= CGPointMake(posX,posy);
    emitter.name = @"explosionSnow";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit =0;
    emitter.zPosition=0.0;
    emitter.speed=5;
    emitter.particleSize=CGSizeMake(height, width);
    emitter.particleLifetime=4.7;
    //[emitter resetSimulation];
    return emitter;
}
- (SKEmitterNode *) newExplosionRain: (float)posX : (float) posy
{
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle2" ofType:@"sks"]];
    emitter.particlePosition= CGPointMake(posX,posy);
    emitter.name = @"explosionRain";
    emitter.targetNode = self.scene;
    emitter.particleBirthRate=500;
    emitter.numParticlesToEmit =0;
    emitter.zPosition=0.0;
    emitter.speed=5;
    emitter.particleSize=CGSizeMake(height, width);
    emitter.particleAlphaRange=0.7;
    emitter.particleLifetime=4.7;
    //[emitter resetSimulation];
    return emitter;
}
-(void)setTemp:(int) h and:(int)w
{
    height=h;
    width=w;
}

- (UIImage*) getImageFromColors:(NSArray*)colors{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors)
        [ar addObject:(id)c.CGColor];
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end= CGPointMake(0.0, self.frame.size.height);
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        //add effect at touch location
//        [self addChild:[self newExplosion:location.x : location.y]];
//        //NSLog(@"%f , %f",location.x,location.y);
//    }
//    
//}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}
@end
