//
//  REHTImageLabel.h
//  REHTImageLabel
//
//  Created by ROCEUN on 03/10/2019.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CutText)

- (void)cutAttributedTextWithWidth;

@end

//MARK: -

@interface REHTImageLabel : UIView

@property (nullable, nonatomic, strong) UIImageView *headImageView;
@property (nullable, nonatomic, strong) UILabel *label; // support textAlignment, lineBreakMode, numberOfLines
@property (nullable, nonatomic, strong) UIImageView *tailImageView;

@property (nonatomic, assign) CGFloat lineMargin;
@property (nonatomic, assign) CGFloat headMargin;
@property (nonatomic, assign) CGFloat tailMargin;


- (void)makeViewWithContentWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
