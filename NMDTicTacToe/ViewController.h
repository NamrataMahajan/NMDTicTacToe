//
//  ViewController.h
//  NMDTicTacToe
//
//  Created by Namrata on 05/11/16.
//  Copyright © 2016 Namrata Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int numberOfTurns,currentPlayer;
    BOOL isGameFinished;
    
    NSArray *winningCombinations;
    NSMutableArray *currentState;
    

}

- (IBAction)actionButton:(id)sender;

@end

