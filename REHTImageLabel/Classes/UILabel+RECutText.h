//
//  UILabel+RECutText.h
//  REHTImageLabel
//
//  Created by ROCEUN on 2020/01/03.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (RECutText)

+ (UILabel *)labelWithAttributedText:(NSAttributedString *)attributedText;

- (void)cutAttributedTextWithWidth;

@end

NS_ASSUME_NONNULL_END
