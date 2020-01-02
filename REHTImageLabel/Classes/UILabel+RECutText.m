//
//  UILabel+RECutText.m
//  REHTImageLabel
//
//  Created by ROCEUN on 2020/01/03.
//

#import "UILabel+RECutText.h"

@implementation UILabel (RECutText)

+ (UILabel *)labelWithAttributedText:(NSAttributedString *)attributedText
{
	UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributedText;
    label.numberOfLines = 1;
    [label sizeToFit];
    return label;
}

- (void)cutAttributedTextWithWidth
{
	NSAttributedString *str = self.attributedText;
	if (str.length == 0)
		return;
	
	CGFloat width = CGRectGetWidth(self.frame), textWidth;

    NSInteger max = [str length];
	textWidth = self.frame.size.width;
    
	UILabel *label = [[UILabel alloc] init];
    if (width <= textWidth) {
        NSInteger newMax = max * width / textWidth;
        for (max = newMax; max <= [str length]; max++) {
			label.attributedText = [str attributedSubstringFromRange:NSMakeRange(0, max)];
			[label sizeToFit];
			textWidth = label.frame.size.width;

            if (width < textWidth) {
                max--;
                break;
            }
        }

        if (newMax > max) {
            do {
                label.attributedText = [str attributedSubstringFromRange:NSMakeRange(0, max)];
				[label sizeToFit];
				textWidth = label.frame.size.width;
            } while (width <= textWidth && max-- >= 0);
        }
    }

    max = MAX(0, MIN(max, str.length));

	self.attributedText = [str attributedSubstringFromRange:NSMakeRange(0, max)];
}

@end
