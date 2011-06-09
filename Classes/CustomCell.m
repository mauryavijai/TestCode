    //
//  CustomCell.m
//  Natolli
//
//  Created by Nidhi Sharma on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"
#import "RootViewController.h"

@implementation CustomCell

@synthesize backgroundImage, alertText, tickImage, btnAction, btnYes, btnNo;

-(void)Hide:(id)sender
{
//	self.hidden = TRUE;
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

/*-(void)Show:(id)sender
{
	//	self.hidden = TRUE;
	[self dismissWithClickedButtonIndex:0 animated:YES];
	
	RootViewController *aSync = [[RootViewController alloc] init];
	aSync.Test;
	
	//RootViewController *theRootViewController =[[self.navigationController viewControllers] objectAtIndex:0];
	//[theRootViewController createToolbarItems:@"NEW"];
}*/

- (id)initWithImage:(UIImage *)image text:(NSString *)text ActionBtnImg:(UIImage *)ActionBtnImg {
    if (self = [super init]) {
		
		alertTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -20, 200, 150)];
		alertTextLabel.textColor = [UIColor colorWithRed:0.12 
												   green:0.12
													blue:0.12
												   alpha:1.0f];
		
		alertTextLabel.backgroundColor = [UIColor clearColor];
		alertTextLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
		alertTextLabel.numberOfLines =0;
		[self addSubview:alertTextLabel];
		
		btnAction = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnAction.frame = CGRectMake(20,75, 141.0f, 41.0f);
		btnAction.backgroundColor = [UIColor clearColor];
		[btnAction setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
		[btnAction setBackgroundImage:ActionBtnImg forState:UIControlStateNormal];
		[btnAction addTarget:self action:@selector(Hide:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btnAction];

        self.backgroundImage = image;
		self.alertText = text;

    }
    return self;
}

- (id) initWithConfirmationImage:(UIImage *)image text:(NSString *)text YesBtnImg:(UIImage *)YesBtnImg NoBtnImg:(UIImage *)NoBtnImg
{
    if (self = [super init]) {
		
		alertConfirmationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 150)];
		alertConfirmationLabel.textColor = [UIColor colorWithRed:0.12 
												   green:0.12
													blue:0.12
												   alpha:1.0f];
		
		alertConfirmationLabel.backgroundColor = [UIColor clearColor];
		alertConfirmationLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:20.0];
		alertConfirmationLabel.numberOfLines =0;
		[self addSubview:alertConfirmationLabel];
		
		btnYes = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnYes.frame = CGRectMake(20,75, 81.0f, 41.0f);
		btnYes.backgroundColor = [UIColor clearColor];
		[btnYes setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
		[btnYes setBackgroundImage:YesBtnImg forState:UIControlStateNormal];
		//[btnYes addTarget:self action:@selector(Hide:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btnYes];
		
		btnNo = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		btnNo.frame = CGRectMake(120,75, 81.0f, 41.0f);
		btnNo.backgroundColor = [UIColor clearColor];
		[btnNo setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
		[btnNo setBackgroundImage:NoBtnImg forState:UIControlStateNormal];
		[btnNo addTarget:self action:@selector(Hide:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btnNo];

        self.backgroundImage = image;
		self.alertText = text;
		
    }
    return self;
}

- (void) setAlertText:(NSString *)text {
	alertTextLabel.text = text;
	alertConfirmationLabel.text = text;
}

- (NSString *) alertText {
	return alertTextLabel.text;
}


- (void)drawRect:(CGRect)rect {
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGSize imageSize = self.backgroundImage.size;
	//CGContextDrawImage(ctx, CGRectMake(0, 0, imageSize.width, imageSize.height), self.backgroundImage.CGImage);
	[self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
}

- (void) layoutSubviews {
	alertTextLabel.transform = CGAffineTransformIdentity;
	[alertTextLabel sizeToFit];
	
	CGRect textRect = alertTextLabel.frame;
	textRect.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(textRect))/2;
	textRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(textRect)) / 2;
	textRect.origin.x = 20.0;
	textRect.origin.y = 10.0;
	
	alertTextLabel.frame = textRect;

	alertConfirmationLabel.transform = CGAffineTransformIdentity;
	[alertConfirmationLabel sizeToFit];
	
	CGRect textRectConf = alertConfirmationLabel.frame;
	//textRectConf.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(textRect))/2;
	//textRectConf.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(textRect)) / 2;
	textRectConf.origin.x = 20.0;
	textRectConf.origin.y = 25.0;
	
	alertConfirmationLabel.frame = textRectConf;
	
	//alertTextLabel.transform = CGAffineTransformMakeRotation(- M_PI * .08);
}

- (void) show {
	[super show];
	
	CGSize imageSize = self.backgroundImage.size;
	self.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
	
	
}


- (void)dealloc {
    [super dealloc];
}


@end
