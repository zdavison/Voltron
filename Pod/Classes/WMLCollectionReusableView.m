//
//  WMLCollectionReusableView.m
//  Pods
//
//  Created by Zachary Davison on 16/12/2014.
//
//

#import "WMLCollectionReusableView.h"

#import "WMLCollectionReusableView+Internal.h"
#import "WMLCollectionReusableViewDelegate.h"

@interface WMLCollectionReusableView ()

@end

@implementation WMLCollectionReusableView

- (void)willMoveToWindow:(UIWindow *)newWindow {
  [super willMoveToWindow:newWindow];
  [self.delegate collectionReusableView:self willMoveToWindow:newWindow];
}

- (void)prepareForReuse {
  [self.delegate collectionReusableViewWillPrepareForReuse:self];
  [super prepareForReuse];
}

@end
