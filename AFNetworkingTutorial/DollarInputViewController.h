//
//  DollarInputViewController.h
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/13/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyConversion.h"

@interface DollarInputViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dollarTextField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
- (IBAction)convertPressed:(id)sender;

@property (strong, nonatomic) id<CurrencyConversion> conversionDelegate;

@end
