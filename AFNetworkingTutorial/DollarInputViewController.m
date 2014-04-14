//
//  DollarInputViewController.m
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/13/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

// 1
#import "DollarInputViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <ProgressHUD/ProgressHUD.h>

// 2
static NSString * OPEN_EXCHANGE_API_ID = @"YOUR APP ID HERE";

@interface DollarInputViewController ()

@end

@implementation DollarInputViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // 3
  self.dollarTextField.delegate = self;
  self.convertButton.enabled    = NO;
}

#pragma mark - IBActions
- (IBAction)convertPressed:(id)sender {
  // 4
  [self showHUD];
  
  // 5
  NSString *baseURL        = @"http://openexchangerates.org/api/";
  NSURL *url               = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", baseURL, @"latest.json?app_id=", OPEN_EXCHANGE_API_ID]];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  
  // 6
  AFHTTPRequestOperation *conversionGETRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
  conversionGETRequest.responseSerializer = [AFJSONResponseSerializer serializer];
  [conversionGETRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    // 7
    NSDictionary *conversionRateDictionary = [responseObject objectForKey:@"rates"];
    
    // 8
    NSURL *conversionURL            = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", baseURL, @"currencies.json?app_id=", OPEN_EXCHANGE_API_ID]];
    NSURLRequest *conversionRequest = [NSURLRequest requestWithURL:conversionURL];
    
    // 9
    AFHTTPRequestOperation *currenciesGETRequest = [[AFHTTPRequestOperation alloc] initWithRequest:conversionRequest];
    currenciesGETRequest.responseSerializer      = [AFJSONResponseSerializer serializer];
    [currenciesGETRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      // 10
      [self.conversionDelegate conversionPerformForDollarAmount:[self getDollarInput]
                                               withExchangeRate:conversionRateDictionary
                                                  andCurrencies:responseObject];
      
      // 11
      [self hideHUD];
      self.convertButton.enabled = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [ProgressHUD showError:error.description Interaction:YES];
    }];
    // 12
    [currenciesGETRequest start];
    

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [ProgressHUD showError:error.description Interaction:YES];
  }];
  //13
  [conversionGETRequest start];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  [self resignFirstResponder];
  self.convertButton.enabled = ![textField.text isEqual:@""];
  return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  self.convertButton.enabled = ![[textField text] isEqual:@""];
  return YES;
}

#pragma mark - private methods
- (void)showHUD {
  self.dollarTextField.enabled = NO;
  self.convertButton.enabled   = NO;
  
  [ProgressHUD show:@"Please wait..."];
}

- (void)hideHUD {
  self.dollarTextField.enabled = YES;
  
  [ProgressHUD dismiss];
}

- (float)getDollarInput {
  return [[self.dollarTextField text] floatValue];
}
@end
