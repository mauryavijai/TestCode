//
//  MainView.m
//  ViewTable
//
//  Created by Chakra on 05/04/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import "MainView.h"


@implementation MainView

@synthesize btnImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}

- (void)LabelText:(NSString *)_text;{
	cellText.text = _text;
}

- (void)ProductImage:(NSString *)_text;{
	
	btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
	[btnImage setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];	
	[btnImage setFrame:CGRectMake(120, 8, 64, 63)];
	NSString *strimageName =[@"" stringByAppendingFormat:@"%@",_text];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *myfile = [documentsPath stringByAppendingPathComponent:strimageName];
	BOOL isfileExists = [[NSFileManager defaultManager] fileExistsAtPath:myfile];

	if(isfileExists)
	{
		[btnImage setBackgroundImage:[[[UIImage alloc]initWithContentsOfFile:myfile] autorelease] forState:UIControlStateNormal]; 
	}
	else 
	{
		[btnImage setBackgroundImage:[UIImage imageNamed:@"add_image.png"] forState:UIControlStateNormal];
	}
	[self.contentView addSubview:btnImage];
}

@end
