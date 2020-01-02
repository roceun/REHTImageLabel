//
//  REHTImageLabel.m
//  REHTImageLabel
//
//  Created by ROCEUN on 03/10/2019.
//

#import "REHTImageLabel.h"

@interface REHTImageLabel () {
	UIView *_contentView;
}

@end

@implementation REHTImageLabel

- (void)dealloc
{
	self.headImageView = nil;
	self.label = nil;
	self.tailImageView = nil;
}

- (CGSize)sizeThatFits:(CGSize)size
{
	[self makeViewWithContentWidth:size.width];
	return _contentView.frame.size;
}

//MARK: -

static inline UILabel * labelWithAttributedText(NSAttributedString *attributedText)
{
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributedText;
    label.numberOfLines = 1;
    [label sizeToFit];
    return label;
}

- (void)makeViewWithContentWidth:(CGFloat)width
{
	[_contentView removeFromSuperview];
	_contentView = nil;

	if (_label.text.length == 0) {
		return;
	}
	
	_contentView = [[UIView alloc] init];
	[self addSubview:_contentView];
	
    UILabel *lineLabel = labelWithAttributedText(_label.attributedText);
    lineLabel.textAlignment = _label.textAlignment;
	
	const CGFloat textHeight = lineLabel.frame.size.height;
	
	CGSize size = CGSizeMake(width, 0);
	NSUInteger index = 0;
	NSUInteger currentLine = 0;
	
	if (_headImageView) {
		[_contentView addSubview:_headImageView];
		_headImageView.frame = (CGRect){CGPointMake(0, ((textHeight - _headImageView.frame.size.height) / 2.f)), _headImageView.frame.size};
		
		CGRect frame = lineLabel.frame;
		frame.origin.x = CGRectGetMaxX(_headImageView.frame) + _headMargin;
		lineLabel.frame = frame;
	}
	
	[_contentView addSubview:lineLabel];
	
	if (_label.numberOfLines != 1 && CGRectGetMaxX(lineLabel.frame) > size.width) {
		while(1) {
			CGRect frame = lineLabel.frame;
			frame.origin.y = ((textHeight + _lineMargin) * currentLine);
			frame.size.width = size.width - frame.origin.x;
			lineLabel.frame = frame;
			[lineLabel cutAttributedTextWithWidth];
			
			index += lineLabel.attributedText.length;
			if (_label.numberOfLines == (currentLine + 1) ||
				index >= _label.attributedText.length) {
				break;
			}
            
            if (_label.lineBreakMode == NSLineBreakByWordWrapping) {
                NSUInteger location = [lineLabel.attributedText.string rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]
                                                                                       options:NSBackwardsSearch].location;
                if (location != NSNotFound) {
                    index -= (lineLabel.attributedText.length - location - 1);
                    lineLabel.attributedText = [lineLabel.attributedText attributedSubstringFromRange:NSMakeRange(0, location)];
                }
            }
			
			currentLine++;
			
			lineLabel = labelWithAttributedText([_label.attributedText
                                                 attributedSubstringFromRange:NSMakeRange(index, _label.attributedText.length - index)]);
            lineLabel.textAlignment = _label.textAlignment;
			[_contentView addSubview:lineLabel];
		}
	}
	[lineLabel sizeToFit];
	
	if (_tailImageView) {
		[_contentView addSubview:_tailImageView];
		
		CGFloat offsetX = CGRectGetMaxX(lineLabel.frame) + _tailMargin;
		CGFloat offsetY = lineLabel.frame.origin.y + ((lineLabel.frame.size.height - _tailImageView.frame.size.height) / 2.f);
		if (size.width - offsetX < _tailImageView.frame.size.width) {
			if (_label.numberOfLines == currentLine + 1) {
				CGRect frame = lineLabel.frame;
				frame.size.width = size.width - frame.origin.x - _tailImageView.frame.size.width - _tailMargin;
				lineLabel.frame = frame;
				
				offsetX = lineLabel.frame.origin.x + lineLabel.frame.size.width + _tailMargin;
			} else {
				offsetX = 0;
				offsetY += (textHeight + _lineMargin);
			}
		}
		_tailImageView.frame = (CGRect){CGPointMake(offsetX, offsetY), _tailImageView.frame.size};
	}
	
	if (lineLabel.frame.origin.y == 0) {
		size.width = CGRectGetMaxX(lineLabel.frame) + CGRectGetWidth(_tailImageView.frame);
	}
	size.height = MAX(CGRectGetMaxY(_tailImageView.frame), CGRectGetMaxY(lineLabel.frame));
	
	CGRect frame = _contentView.frame;
	frame.size = size;
	_contentView.frame = frame;
	
	[self sendSubviewToBack:_contentView];
}

@end


//MARK: -

@implementation UILabel (CutText)

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
