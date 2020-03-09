//
//  REHTImageArrayLabel.m
//  REHTImageLabel
//
//  Created by ROCEUN on 2020/01/03.
//

#import "REHTImageArrayLabel.h"
#import "UILabel+RECutText.h"

@interface REHTImageArrayLabel () {
	UIView *_contentView;
}

@end

@implementation REHTImageArrayLabel

- (void)dealloc
{
	self.headImageViewArray = nil;
	self.label = nil;
	self.tailImageViewArray = nil;
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
	
	if (_headImageViewArray.count > 0) {
		CGFloat offsetX = 0;
		
		for (UIImageView *headImageView in _headImageViewArray) {
			if (offsetX + headImageView.frame.size.width > size.width) {
				if (_label.numberOfLines == (currentLine + 1)) {
					break;
				}
				offsetX = 0;
				size.height += (textHeight + _lineMargin);
				currentLine++;
			}
			[_contentView addSubview:headImageView];
			
			const CGFloat offsetY = size.height + ((textHeight - headImageView.frame.size.height) / 2.f);
			headImageView.frame = (CGRect){CGPointMake(offsetX, offsetY), headImageView.frame.size};
			offsetX = CGRectGetMaxX(headImageView.frame);
		}
		
		if (offsetX > 0 || currentLine > 0) {
			if (offsetX + _headMargin > size.width) {
				offsetX = 0;
				size.height += (textHeight + _lineMargin);
				currentLine++;
			} else {
				offsetX += _headMargin;
			}
			
			CGRect frame = lineLabel.frame;
			frame.origin.x = offsetX;
			frame.origin.y = size.height;
			lineLabel.frame = frame;
		}
	}
	
	if (_label.numberOfLines == 0 || _label.numberOfLines > currentLine) {
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
		
		size.height = lineLabel.frame.origin.y;
	}
	
	if (_label.numberOfLines == 0 || _label.numberOfLines > currentLine) {
		CGFloat offsetX = CGRectGetMaxX(lineLabel.frame) + _tailMargin;
		
		for (UIImageView *tailImageView in _tailImageViewArray) {
			if (offsetX + tailImageView.frame.size.width > size.width) {
				if (_label.numberOfLines == (currentLine + 1)) {
					break;
				}
				offsetX = 0;
				size.height += (textHeight + _lineMargin);
				currentLine++;
			}
			
			[_contentView addSubview:tailImageView];
			
			const CGFloat offsetY = size.height + ((textHeight - tailImageView.frame.size.height) / 2.f);
			tailImageView.frame = (CGRect){CGPointMake(offsetX, offsetY), tailImageView.frame.size};
			offsetX = CGRectGetMaxX(tailImageView.frame);
		}
	}
	
	if (currentLine == 0) {
		size.width = CGRectGetMaxX(_contentView.subviews.lastObject.frame);
	}
	size.height += (textHeight + _lineMargin);
	
	CGRect frame = _contentView.frame;
	frame.size = size;
	_contentView.frame = frame;
	
	[self sendSubviewToBack:_contentView];
}

@end
