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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:[self.newsLetter  objectForKey:@"url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView delegate implementation
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error web");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Request: %@", request);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"Finish web");
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"Start web");
}

@end
