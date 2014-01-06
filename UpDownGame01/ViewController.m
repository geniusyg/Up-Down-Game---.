//
//  ViewController.m
//  UpDownGame01
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate> {
	int answer;
	int maxTrial;
	int trial;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ViewController

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == alertView.firstOtherButtonIndex) {
		[self newGame:nil];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[self.userInput becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self newGame:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self checkInput:nil];
	return YES;
}

- (IBAction)newGame:(id)sender {
	int selectedGame = self.gameSelector.selectedSegmentIndex;
	int maxmumRandom = 0;
	if(0==selectedGame) {
		maxTrial = 5;
		maxmumRandom = 10;
	} else if(1==selectedGame) {
		maxTrial = 10;
		maxmumRandom = 50;
	} else {
		maxTrial = 20;
		maxmumRandom = 100;
	}
	
	self->answer = random()%maxmumRandom +1;
	self->trial = 0;
	self.progress.progress = 0.0f;
	self.label.text = @"";
	self.countLabel.text = @"";
	
	NSLog(@"New Game with answer = %d", self->answer);
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkInput:(id)sender {
	int inputVal = [self.userInput.text intValue];
	self.userInput.text = @"";
	
	if(self->answer == inputVal) {
		self.label.text = @"정답입니다!";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"정답" message:@"다시 게임 할래?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
		alert.tag = 11;
		[alert show];
	} else {
		self->trial++;
		if(trial >= maxTrial){
			NSString *msg = [NSString stringWithFormat:@"답은 %d입니다.",self->answer];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"실패" message:msg delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
			alert.tag = 12;
			[alert show];
		} else {
			if(self->answer > inputVal) {
				self.label.text = @"Down";
			} else {
				self.label.text = @"Up";
			}
			self.countLabel.text = [NSString stringWithFormat:@"%d / %d",trial,maxTrial];
			
			self.progress.progress = trial / (float)maxTrial;
		}
		
	}
}

@end

































