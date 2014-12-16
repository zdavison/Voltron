//
//  WMLCollectionReusableView+Internal.h
//  Pods
//
//  Created by Zachary Davison on 16/12/2014.
//
//


#import "WMLCollectionReusableView.h"

@protocol WMLCollectionReusableViewDelegate;
@interface WMLCollectionReusableView ()

@property (nonatomic, weak) id<WMLCollectionReusableViewDelegate> delegate;

@property (nonatomic, strong) id contentViewController;

@end

