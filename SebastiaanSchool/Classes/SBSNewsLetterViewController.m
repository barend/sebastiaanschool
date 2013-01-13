//
//  SBSNewsLetterViewController.m
//  SebastiaanSchool
//
//  Created by Jeroen Leenarts on 11-01-13.
//
//

#import "SBSNewsLetterViewController.h"

@interface SBSNewsLetterViewController ()

@property (nonatomic, strong) PFObject * newsLetter;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation SBSNewsLetterViewController

- (id)initWithNewsLetter:(PFObject *)newsLetter {
    self = [super init];
    if (self) {
        _newsLetter = newsLetter;
    }

    return self;
}

- (void)loadView{
    [super loadView];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    CGRect activityFrame = self.activityIndicator.frame;
    activityFrame.origin.y = (self.view.bounds.size.height - activityFrame.size.height) / 2.0f;
    activityFrame.origin.x = (self.view.bounds.size.width - activityFrame.size.width) / 2.0f;
    self.activityIndicator.frame = CGRectIntegral(activityFrame);
    [self.view addSubview:self.activityIndicator];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[self.newsLetter  objectForKey:@"url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebView delegate implementation
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error web");
    [self.activityIndicator stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Request: %@", request);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Finish web");
    [self.activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Start web");
    [self.activityIndicator startAnimating];
}

@end
