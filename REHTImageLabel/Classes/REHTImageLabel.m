//
//  REHTImageLabel.m
//  REHTImageLabel
//
//  Created by ROCEUN on 03/10/2019.
//

#import "REHTImageLabel.h"
#import "UILabel+RECutText.h"

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

- (void)makeViewWithContentWidth:(CGFloat)width
{
	[_contentView removeFromSuperview];
	_contentView = nil;

	if (_label.text.length == 0) {
		return;
	}
	
	_contentView = [[UIView alloc] init];
	[self addSubview:_contentView];
	
	UILabel *lineLabel = [UILabel labelWithAttributedText:_label.attributedText];
	
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
				index -= lineLabel.attributedText.length;
				lineLabel.attributedText = [_label.attributedText
											attributedSubstringFromRange:NSMakeRange(index, _label.attributedText.length - index)];
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
			
			lineLabel = [UILabel labelWithAttributedText:[_label.attributedText
														  attributedSubstringFromRange:NSMakeRange(index, _label.attributedText.length - index)]];
			[_contentView addSubview:lineLabel];
		}
		[lineLabel sizeToFit];
	}
	
	if (CGRectGetMaxX(lineLabel.frame) > size.width) {
		CGRect frame = lineLabel.frame;
		frame.size.width = size.width - frame.origin.x;
		lineLabel.frame = frame;
	}
	
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
		size.width = CGRectGetMaxX(lineLabel.frame) + CGRectGetWidth(_tailImageView.frame) + _tailMargin;
	}
	size.height = CGRectGetMaxY(lineLabel.frame) + _lineMargin;
	
	CGRect frame = _contentView.frame;
	frame.size = size;
	_contentView.frame = frame;
	
	[self sendSubviewToBack:_contentView];
}

@end
