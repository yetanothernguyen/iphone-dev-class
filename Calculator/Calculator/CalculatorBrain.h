//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Nguyen Vu Nguyen on 9/21/12.
//  Copyright (c) 2012 Nguyen Vu Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clear;
@end
