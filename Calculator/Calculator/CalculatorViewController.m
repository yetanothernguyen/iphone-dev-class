//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Nguyen Vu Nguyen on 9/20/12.
//  Copyright (c) 2012 Nguyen Vu Nguyen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL numberHasDecimal;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display;
@synthesize log;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain  = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if ([digit isEqualToString:@"."]) {
        NSRange range = [self.display.text rangeOfString:@"."];
        if (range.location == NSNotFound) {
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.userIsInTheMiddleOfEnteringANumber = YES;
            [self logText:digit];
        }
    } else if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        [self logText:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
        [self logText:digit];
    }

}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.numberHasDecimal = NO;
    self.display.text = @"";
    [self logText:@" "];
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = sender.currentTitle;
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    [self logText:operation];
    [self logText:@" "];
}

- (IBAction)clearPressed {
    [self.brain clear];
    self.log.text = @"";
    self.display.text = @"";
}

- (void)logText:(NSString *)string {
    self.log.text = [self.log.text stringByAppendingString:string];
}

- (void)viewDidUnload {
    [self setLog:nil];
    [super viewDidUnload];
}
@end
