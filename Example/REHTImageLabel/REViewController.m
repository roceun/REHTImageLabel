//
//  REViewController.m
//  REHTImageLabel
//
//  Created by roceun on 10/03/2019.
//  Copyright (c) 2019 roceun. All rights reserved.
//

#import "REViewController.h"

#import <REHTImageLabel.h>
#import <REHTImageArrayLabel.h>

@interface REViewController ()

@end

@implementation REViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self initREHTImageLabelWithNumOfLines:1 withOffsetY:100];
	[self initREHTImageLabelWithNumOfLines:2 withOffsetY:100+50];
	[self initREHTImageLabelWithNumOfLines:0 withOffsetY:100+50+70];
	
	[self initREHTImageArrayLabelWithNumOfLines:1 withOffsetY:350];
	[self initREHTImageArrayLabelWithNumOfLines:2 withOffsetY:350+50];
	[self initREHTImageArrayLabelWithNumOfLines:0 withOffsetY:350+50+70];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initREHTImageLabelWithNumOfLines:(NSInteger)numberOfLines withOffsetY:(CGFloat)offsetY
{
	REHTImageLabel *imageLabel = [[REHTImageLabel alloc] initWithFrame:CGRectMake(16.f, offsetY, self.view.frame.size.width - 32.f, 0)];
	imageLabel.lineMargin = 4.f;
	imageLabel.headMargin = 8.f;
	imageLabel.tailMargin = 8.f;
	[self.view addSubview:imageLabel];
	
	NSString *const string = [[NSString alloc] initWithFormat:@"Label with head and tail imageview. Support textAlignment, lineBreakMode, numberOfLines. This is REHTImageLabel example with numberOfLine is %d", (int)numberOfLines];
	UILabel *label = [[UILabel alloc] init];
	label.attributedText = [[NSAttributedString alloc] initWithString:string
														   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
	label.numberOfLines = numberOfLines;
	imageLabel.label = label;
	
	UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	headImageView.backgroundColor = [UIColor blueColor];
	imageLabel.headImageView = headImageView;
	
	UIImageView *tailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	tailImageView.backgroundColor = [UIColor redColor];
	imageLabel.tailImageView = tailImageView;
	
	[imageLabel sizeToFit];
}

- (void)initREHTImageArrayLabelWithNumOfLines:(NSInteger)numberOfLines withOffsetY:(CGFloat)offsetY
{
	REHTImageArrayLabel *imageLabel = [[REHTImageArrayLabel alloc] initWithFrame:CGRectMake(16.f, offsetY, self.view.frame.size.width - 32.f, 0)];
	imageLabel.lineMargin = 4.f;
	imageLabel.headMargin = 8.f;
	imageLabel.tailMargin = 8.f;
	[self.view addSubview:imageLabel];
	
	NSString *const string = [[NSString alloc] initWithFormat:@"Label with head and tail imageview. Support textAlignment, lineBreakMode, numberOfLines. This is REHTImageArrayLabel example with numberOfLine is %d", (int)numberOfLines];
	UILabel *label = [[UILabel alloc] init];
	label.attributedText = [[NSAttributedString alloc] initWithString:string
														   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
	label.numberOfLines = numberOfLines;
	imageLabel.label = label;
	
	NSMutableArray *mutableArray = [NSMutableArray new];
	for (int i = 0; i < 5; i++) {
		UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		headImageView.backgroundColor = [UIColor blueColor];
		[mutableArray addObject:headImageView];
	}
	imageLabel.headImageViewArray = mutableArray.copy;
	
	mutableArray = [NSMutableArray new];
	for (int i = 0; i < 5; i++) {
		UIImageView *tailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		tailImageView.backgroundColor = [UIColor redColor];
		[mutableArray addObject:tailImageView];
	}
	imageLabel.tailImageViewArray = mutableArray.copy;
	
	[imageLabel sizeToFit];
}

@end
