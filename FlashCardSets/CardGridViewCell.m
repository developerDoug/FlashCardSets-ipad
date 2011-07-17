//
//  CardGridViewCell.m
//  FlashCardSets
//
//  Created by Douglas Mason on 7/16/11.
//  Copyright 2011 DeveloperDoug. All rights reserved.
//

#import "CardGridViewCell.h"

@implementation CardGridViewCell

- (void) dealloc
{
    [_imageView release];
    [super dealloc];
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( ([super initWithFrame:frame reuseIdentifier:reuseIdentifier]) )
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (CALayer *) glowSelectionLayer
{
    return ( _imageView.layer );
}

- (UIImage *) image
{
    return _imageView.image;
}

- (void) setImage:(UIImage *)anImage
{
    _imageView.image = anImage;
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageSize = _imageView.image.size;
    CGRect frame = _imageView.frame;
    CGRect bounds = self.contentView.bounds;
    
    if ( (imageSize.width <= bounds.size.width) &&
        (imageSize.height <= bounds.size.height) )
    {
        return;
    }
    
    // scale it down to fit
    CGFloat hRatio = bounds.size.width / imageSize.width;
    CGFloat vRatio = bounds.size.height / imageSize.height;
    CGFloat ratio = MAX(hRatio, vRatio);
    
    frame.size.width = floorf(imageSize.width * ratio);
    frame.size.height = floorf(imageSize.height * ratio);
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5);
    frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5);
    _imageView.frame = frame;
}

@end
