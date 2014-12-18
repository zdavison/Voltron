//
//  WMLCollectionView.m
//  ControllerCollectionView
//
//  Created by Sash Zats on 10/4/14.
//  Copyright (c) 2014 Wondermall. All rights reserved.
//

#import "WMLCollectionView.h"

#import "WMLCollectionViewCell.h"
#import "WMLCollectionViewCell+Internal.h"
#import "WMLCollectionViewCellDelegate.h"

#import "WMLCollectionReusableView.h"
#import "WMLCollectionReusableView+Internal.h"
#import "WMLCollectionReusableViewDelegate.h"

@interface WMLCollectionView () <WMLCollectionViewCellDelegate, WMLCollectionReusableViewDelegate>

@end

@implementation WMLCollectionView

- (id)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier
                                forIndexPath:(NSIndexPath *)indexPath {
    WMLCollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier
                                               forIndexPath:indexPath];
    if (![cell isKindOfClass:[WMLCollectionViewCell class]]) {
        return cell;
    }
    cell.delegate = self;
    if (!cell.contentViewController) {
        UIViewController *controller = [self.dataSource collectionView:self
                                               controllerForIdentifier:identifier];
        NSAssert(controller && [controller isKindOfClass:[UIViewController class]], @"The collection view's data source did not return a valid view controller for identifier %@", identifier);
        cell.contentViewController = controller;
    }
    return cell;
}

- (id)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind
                         withReuseIdentifier:(NSString *)identifier
                                forIndexPath:(NSIndexPath *)indexPath{
  WMLCollectionReusableView *cell = [super dequeueReusableSupplementaryViewOfKind:elementKind
                                                              withReuseIdentifier:identifier
                                                                     forIndexPath:indexPath];
  if (![cell isKindOfClass:[WMLCollectionReusableView class]]) {
    return cell;
  }
  cell.delegate = self;
  if (!cell.contentViewController) {
    UIViewController *controller = [self.dataSource collectionView:self
                                           controllerForIdentifier:identifier];
    NSAssert(controller && [controller isKindOfClass:[UIViewController class]], @"The collection view's data source did not return a valid view controller for identifier %@", identifier);
    cell.contentViewController = controller;
  }
  return cell;
}

#pragma mark - Public

- (void)didEndDisplayingCell:(WMLCollectionViewCell *)cell {
    if (![cell isKindOfClass:[WMLCollectionViewCell class]]) {
        return;
    }
    UIViewController *controller = cell.contentViewController;
    [self _unhostViewController:controller];
}

#pragma mark - Private

- (void)_unhostViewController:(UIViewController *)controller {
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

- (void)_hostViewController:(UIViewController *)controller
               withHostView:(UIView *)superview {
    [self.containerViewController addChildViewController:controller];
    controller.view.frame = superview.bounds;
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [superview addSubview:controller.view];
    [controller didMoveToParentViewController:self.containerViewController];
}

#pragma mark - WMLCollectionViewCellDelegate

- (void)collectionViewCell:(WMLCollectionViewCell *)cell willMoveToWindow:(UIWindow *)window {
    [self _hostViewController:cell.contentViewController
                withHostView:cell.contentView];
}

- (void)collectionViewCellWillPrepareForReuse:(WMLCollectionViewCell *)cell {
    [self _hostViewController:cell.contentViewController
                withHostView:cell.contentView];
}

#pragma mark - WMLCollectionReusableViewDelegate

- (void)collectionReusableView:(WMLCollectionReusableView *)reusableView willMoveToWindow:(UIWindow *)window {
  [self _hostViewController:reusableView.contentViewController
               withHostView:reusableView];
}

- (void)collectionReusableViewWillPrepareForReuse:(WMLCollectionReusableView *)reusableView {
  [self _hostViewController:reusableView.contentViewController
               withHostView:reusableView];
}

@end
