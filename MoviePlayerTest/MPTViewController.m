
#import "MPTViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface MPTViewController ()

@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation MPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://r11---sn-ogueynll.googlevideo.com/videoplayback?mv=m&ratebypass=yes&source=youtube&ms=au&itag=18&sparams=id,ip,ipbits,itag,ratebypass,source,upn,expire&expire=1399475784&upn=9qoqShEeJ2I&key=yt5&id=o-APwzg3oPMZqOhqwVLnjqUP0Dxqc376GMC5Xv7GKLRas8&mt=1399451592&ipbits=0&fexp=941286,937417,913434,923341,936923,945044&sver=3&mws=yes&ip=113.36.238.28&signature=24B9338FE1560B40D1EAFC1BE0A77D70A43AA1D3.2A40E34320DA17EDA0ABBD88241477B28B7546DB"];
    
    MPMoviePlayerController *movielayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // MoviePlayerを保持
    self.player = movielayer;
    
    // 動画読み込み後に呼ばれるNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePreloadDidFinish:)
                                                 name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:movielayer];

    // 動画の再生終了後に呼ばれるNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayerPlaybackDisFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:movielayer];
    
    movielayer.view.frame = CGRectMake(0, 0, 320, 200);
    [self.view addSubview:movielayer.view];
    
    // 再生開始
    [movielayer prepareToPlay];
}

-(void)moviePreloadDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:nil];
    // Preloadが終わったら呼ばれる
}

- (void)moviePlayerPlaybackDisFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
    // 動画の再生が終わったら呼ばれる
}

@end
