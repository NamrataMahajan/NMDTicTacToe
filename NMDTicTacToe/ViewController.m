//
//  ViewController.m
//  NMDTicTacToe
//
//  Created by Namrata on 05/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initGame];

}
-(void)initGame {
    numberOfTurns = 0;
    currentPlayer = 1;
    isGameFinished = false;
    
    winningCombinations = @[@[@0,@1,@2],@[@3,@4,@5],@[@6,@7,@8],@[@0,@3,@6],@[@1,@4,@7],@[@2,@5,@8],@[@0,@4,@8],@[@2,@4,@6]];
    
    currentState = [[NSMutableArray alloc]initWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    for (int i = 100; i<=108; i++) {
        UIButton *button = [self.view viewWithTag:i];
        NSLog(@"%ld",(long)button.tag);
        [button setImage:[UIImage new] forState:UIControlStateNormal];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)win:(NSString *)player
{
    [self showAlertWithTitle:@"Won" message:[NSString stringWithFormat:@"congrats!,%@ won the game",player]];
}

-(void) showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok Button Pressed !");
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)alertForEndWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self initGame];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [alert addAction:ok];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
        
    }];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (IBAction)actionButton:(id)sender {
    
    numberOfTurns = numberOfTurns + 1;
    
    UIButton *tile = sender;
    UIImage *playerImage;
    int player = currentPlayer;
    
    BOOL isButtonNotSelected = [[currentState objectAtIndex:(tile.tag - 100)] isEqual:@0];
    
    if (isButtonNotSelected) {
        
        if (!isGameFinished) {
            if (player == 1) {
                playerImage = [UIImage imageNamed:@"nought"];
                [currentState replaceObjectAtIndex:(tile.tag - 100) withObject:@1];
                
                currentPlayer = 2;
            }
            else
                
            {
                playerImage = [UIImage imageNamed:@"cross"];
                [currentState replaceObjectAtIndex:(tile.tag - 100) withObject:@2];
                currentPlayer = 1;
            }
        }
        [tile setImage:playerImage forState:UIControlStateNormal];
    }
    else {
        [self showAlertWithTitle:@"Caution" message:@"Please select another tile" ];
    }
    
    
    if (numberOfTurns >=5) {
        for (NSArray *combination in winningCombinations) {
            int indexOfButtnOne = [[combination objectAtIndex:0]intValue];
            int indexOfButtnTwo = [[combination objectAtIndex:1]intValue];
            int indexOfButtnThree = [[combination objectAtIndex:2]intValue];
            NSNumber *stateAtButtonOne = [currentState objectAtIndex:indexOfButtnOne];
            NSNumber *stateAtButtonTwo = [currentState objectAtIndex:indexOfButtnTwo];
            NSNumber *stateAtButtonThree = [currentState objectAtIndex:indexOfButtnThree];
            
            if (![stateAtButtonOne isEqual:@0] && [stateAtButtonOne isEqual:stateAtButtonTwo] && [stateAtButtonTwo isEqual:stateAtButtonThree])
            {
                isGameFinished = YES;
                NSString *winnerString = [NSString stringWithFormat:@"Player %d has Won",player];
                
                [self alertForEndWithTitle:winnerString message:@"Do you want to play again"];
                break;
            }
        }
    }
    if (!isGameFinished) {
        BOOL zeroValuePresent = [currentState containsObject:@0];
        
        if (!zeroValuePresent) {
            [self alertForEndWithTitle:@"Game Draw" message:@"Do you want to play again"];
        }
    }
    
}
@end
