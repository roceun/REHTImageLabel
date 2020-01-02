//
//  REViewController.m
//  REHTImageLabel
//
//  Created by roceun on 10/03/2019.
//  Copyright (c) 2019 roceun. All rights reserved.
//

#import "REViewController.h"

#import <REHTImageLabel.h>

@interface REViewController ()

@end

@implementation REViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	REHTImageLabel *imageLabel = [[REHTImageLabel alloc] initWithFrame:CGRectMake(16.f, 100, self.view.frame.size.width - 32.f, 0)];
	imageLabel.lineMargin = 4.f;
	imageLabel.headMargin = 8.f;
	imageLabel.tailMargin = 8.f;
	[self.view addSubview:imageLabel];
	
	NSString *const string = @"Label with head and tail imageview. Support textAlignment, lineBreakMode, numberOfLines";
	UILabel *label = [[UILabel alloc] init];
	label.attributedText = [[NSAttributedString alloc] initWithString:string
														   attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}];
	label.numberOfLines = 0;
	imageLabel.label = label;
	
	UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	headImageView.backgroundColor = [UIColor blueColor];
	imageLabel.headImageView = headImageView;
	
	UIImageView *tailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
	tailImageView.backgroundColor = [UIColor redColor];
	imageLabel.tailImageView = tailImageView;
	
	[imageLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
