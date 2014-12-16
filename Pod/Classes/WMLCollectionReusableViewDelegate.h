//
//  WMLCollectionReusableViewDelegate.h
//  Pods
//
//  Created by Zachary Davison on 16/12/2014.
//
//

@class WMLCollectionReusableView;
@protocol WMLCollectionReusableViewDelegate <NSObject>

- (void)collectionReusableViewWillPrepareForReuse:(WMLCollectionReusableView *)reusableView;

- (void)collectionReusableView:(WMLCollectionReusableView *)reusableView
          willMoveToWindow:(UIWindow *)window;

@end
