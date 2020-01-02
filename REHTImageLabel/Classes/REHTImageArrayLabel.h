//
//  REHTImageArrayLabel.h
//  REHTImageLabel
//
//  Created by ROCEUN on 2020/01/03.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface REHTImageArrayLabel : UIView

@property (nullable, nonatomic, strong) NSArray<UIImageView *> *headImageViewArray;
@property (nullable, nonatomic, strong) UILabel *label; // support textAlignment, lineBreakMode, numberOfLines
@property (nullable, nonatomic, strong) NSArray<UIImageView *> *tailImageViewArray;

@property (nonatomic, assign) CGFloat lineMargin;
@property (nonatomic, assign) CGFloat headMargin;
@property (nonatomic, assign) CGFloat tailMargin;


- (void)makeViewWithContentWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
