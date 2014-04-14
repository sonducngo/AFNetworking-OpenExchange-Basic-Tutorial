//
//  CurrencyConversion.h
//  AFNetworkingTutorial
//
//  Created by Son Ngo on 4/13/14.
//  Copyright (c) 2014 Son Ngo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CurrencyConversion <NSObject>
- (void)conversionPerformForDollarAmount:(float)dollarAmount withExchangeRate:(NSDictionary *)exchangeRateDict andCurrencies:(NSDictionary *)currenciesDict;
@end
