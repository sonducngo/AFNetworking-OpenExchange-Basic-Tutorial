//
//  SearchSplitViewController.m
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/12/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "SearchSplitViewController.h"
#import "DetailViewController.h"
#import "DollarInputViewController.h"

@interface SearchSplitViewController ()

@end

@implementation SearchSplitViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  DollarInputViewController *leftVC = [self.viewControllers objectAtIndex:0];
  DetailViewController *rightVC     = [self.viewControllers objectAtIndex:1];
  
  leftVC.conversionDelegate = rightVC;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
