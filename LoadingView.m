//
//  LoadingView.m
//  Ambisoft - http://www.ambisoft.net
//
//  Created by Marek Publicewicz on 3/3/14.
//  Copyright (c) 2014 Mark Publicewicz. All rights reserved.
//

#import "LoadingView.h"

static const CGFloat LABEL_WIDTH = 200;
static const CGFloat LABEL_HEIGHT = 50;
static const CGFloat LABEL_VERTICAL_OFFSET = 30;

static const CGFloat AUTO_CLOSE_DELAY = 5.0f;
static const CGFloat TRANSPARENCY = 0.5f;

static NSString *LABEL_TEXT = @"Please wait...";

@interface LoadingView()
{
}

-(void)configureLabel;
-(void)configureSpinner;
-(void)removeOverlay;

@end

@implementation LoadingView

-(instancetype)initWithParent:(UIView*)parentView
{
    UIWindow *window = parentView.window;
    if (self = [super initWithFrame:window.bounds]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:TRANSPARENCY];
        self.userInteractionEnabled = YES;
        
        [self configureSpinner];
        [self configureLabel];
        
        [window addSubview:self];
        
        [self performSelector:@selector(removeOverlay) withObject:nil
                   afterDelay:AUTO_CLOSE_DELAY];
        
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeOverlay];
}

-(void)hide
{
    [self removeOverlay];
}

-(void)removeOverlay
{
    [self removeFromSuperview];
}

-(CGRect)centerFrame:(CGRect)frame inParent:(CGRect)parentFrame
{
    frame.origin.x = parentFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = parentFrame.size.height / 2 - frame.size.height / 2;
    return frame;
}

-(void)configureLabel
{
    CGRect labelFrame = CGRectMake(0, 0, LABEL_WIDTH, LABEL_HEIGHT);
    UILabel * label = [[UILabel alloc] initWithFrame:labelFrame];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    
    label.text = LABEL_TEXT;
    
    label.frame = [self centerFrame:label.frame inParent:self.frame];
    
    CGRect frame = label.frame;
    frame.origin.y += LABEL_VERTICAL_OFFSET;
    label.frame = frame;
    
    [self addSubview:label];
}

-(void)configureSpinner
{
    UIActivityIndicatorView *aiv =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    aiv.frame = [self centerFrame:aiv.frame inParent:self.frame];
    [aiv startAnimating];
    [self addSubview:aiv];
}

@end
