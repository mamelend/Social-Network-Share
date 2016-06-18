//
//  ViewController.m
//  SocialNetworkingApp
//
//  Created by Miguel Melendez on 6/6/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"
#define ARC4RANDOM_MAX 0x100000000

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *twitterTextView;
@property (weak, nonatomic) IBOutlet UITextView *facebookTextView;
@property (weak, nonatomic) IBOutlet UITextView *moreTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextView:_twitterTextView];
    [self configureTextView:_facebookTextView];
    [self configureTextView:_moreTextView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureTextView:(UITextView *)temp {
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    temp.layer.backgroundColor = [UIColor colorWithRed:val
                                green:val blue:1.0 alpha: 1.0].
    CGColor;
    temp.layer.borderColor = [UIColor colorWithWhite:50 alpha:0.5].CGColor;
    temp.layer.borderWidth = 1.0;
}

- (void)showAlertMessage:(NSString *) myMessage {
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)twitterButtonPressed:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        SLComposeViewController *twitterViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        if([self.twitterTextView.text length] < 140) {
            [twitterViewController setInitialText:self.twitterTextView.text];
        } else {
            NSString *shortText = [self.twitterTextView.text substringToIndex:140];
            [twitterViewController setInitialText:shortText];
        }
        
        [self presentViewController:twitterViewController animated:YES completion:nil];
    } else {
        //Raise objection
        [self showAlertMessage:@"You are not signed into Twiiter."];
    }
}

- (IBAction)facebookButtonPressed:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookViewController setInitialText:_facebookTextView.text];
        [self presentViewController:facebookViewController animated:YES completion:nil];

    } else {
        [self showAlertMessage:@"You are not signed into Facebook."];
    }
}

- (IBAction)moreButtonPressed:(id)sender {
    UIActivityViewController *moreViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextView.text] applicationActivities:nil];
    [self presentViewController:moreViewController animated:YES completion:nil];
}

- (IBAction)popupButtonPressed:(id)sender {
    [self showAlertMessage:@"Thanks for using my app!"];
}

@end
