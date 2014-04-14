//
//  DetailViewController.h
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/12/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyConversion.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, CurrencyConversion>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
