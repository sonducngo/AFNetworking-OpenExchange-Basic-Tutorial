//
//  DetailViewController.m
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/12/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

// 1
@property (strong, nonatomic) NSDictionary *exchangeRateDict;
@property (strong, nonatomic) NSDictionary *currenciesDict;
@property float dollarAmount;

@end

#pragma mark -
@implementation DetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // 2
  self.tableView.dataSource = self;
}

// 3
#pragma mark - CurrencyConversion protocol
- (void)conversionPerformForDollarAmount:(float)dollarAmount withExchangeRate:(NSDictionary *)exchangeRateDict andCurrencies:(NSDictionary *)currenciesDict {
  self.dollarAmount     = dollarAmount;
  self.exchangeRateDict = exchangeRateDict;
  self.currenciesDict   = currenciesDict;

  [self.tableView reloadData];
}

// 4
#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  NSString *currencyKey  = [self getCurrencyKey:indexPath];
  NSString *currencyName = [self.currenciesDict objectForKey:currencyKey];
  
  cell.textLabel.text       = [NSString stringWithFormat:@"%@ (%@)", currencyName, currencyKey];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %@", [self getConversionRate:currencyKey]];
  
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.exchangeRateDict count];
}

#pragma mark - private methods
- (NSString *)getConversionRate:(NSString *)currencyKey {
  NSNumber *number = [self.exchangeRateDict objectForKey:currencyKey];
  return [NSString stringWithFormat:@"%.02f", [number floatValue] * self.dollarAmount];
}

- (NSString *)getCurrencyKey:(NSIndexPath *)indexPath {
  NSArray *allCurrencyKeys = [self.currenciesDict allKeys];
  return [allCurrencyKeys objectAtIndex:indexPath.row];
}

@end
