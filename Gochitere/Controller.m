/*****************************************************************************
 * test: Controller.m
 *****************************************************************************
 * Copyright (C) 2007-2013 Pierre d'Herbemont and VideoLAN
 *
 * Authors: Pierre d'Herbemont
 *          Felix Paul Kühne
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/
//  Gochitere
//
//  Created by otti on 2021/01/03.
//

#import "Controller.h"
//#import "subController.m"

@implementation Controller

- (void)awakeFromNib
{
    [NSApp setDelegate:self];
    // Allocate a VLCVideoView instance and tell it what area to occupy.
    //NSRect rect = NSMakeRect(0, 0, videoHolderView.frame.size.width, videoHolderView.frame.size.height);
    NSRect rect = NSMakeRect(0, 0, 0, 0);
    rect.size = [videoHolderView frame].size;
    videoView = [[VLCVideoView alloc] initWithFrame:rect];
    [videoHolderView addSubview:videoView];
    [videoView setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
    videoView.fillScreen = YES;
    player = [[VLCMediaPlayer alloc] initWithVideoView:videoView];
    player.delegate = self;
    player.drawable = videoHolderView;
    player.media = [VLCMedia alloc];
    player.media.delegate = self;

    //player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@ "http://192.168.20.9:40772/api/channels/GR/12/stream"]];
    //[player play];
    if ([self existChannel]){
    }else{
        [self inputMirakurun];
        [self getChannel];
    }
        [self createChannel];
    NSLog(@"awake state done.");
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    NSLog(@"Application Launched");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    NSLog(@"Application Terminate");
    [player pause];
    [player stop];
    [player setMedia:nil];
    [player release];
    [videoView release];
}

- (void)changeAndPlay:(id)sender
{

}

- (void)makeAudioMenu{
    NSLog(@"make Audio ...");
    NSMenu *subMenu = [[[NSMenu alloc] init] autorelease];
    NSArray *menuArrAudios = [player audioTrackNames];
    NSLog(@"%ld", [menuArrAudios count]);
    if([menuArrAudios count] == 0){
    }else if([menuArrAudios count] == 1){
        [subMenu addItemWithTitle:menuArrAudios[0] action:@selector(menuAudio0:) keyEquivalent:@""];
    }else if([menuArrAudios count] == 2){
        [subMenu addItemWithTitle:menuArrAudios[0] action:@selector(menuAudio0:) keyEquivalent:@""];
        [subMenu addItemWithTitle:menuArrAudios[1] action:@selector(menuAudio1:) keyEquivalent:@""];
    }else if([menuArrAudios count] == 3){
        [subMenu addItemWithTitle:menuArrAudios[0] action:@selector(menuAudio0:) keyEquivalent:@""];
        [subMenu addItemWithTitle:menuArrAudios[1] action:@selector(menuAudio1:) keyEquivalent:@""];
        [subMenu addItemWithTitle:menuArrAudios[2] action:@selector(menuAudio2:) keyEquivalent:@""];
    }
    [mAudio setSubmenu:subMenu];
}

- (void)menuAudio:(NSMenuItem *)sender{
    NSArray *menuArrSubTitlesIndexs = [player videoSubTitlesIndexes];
    player.currentVideoSubTitleIndex = [menuArrSubTitlesIndexs[0] intValue];
}

- (void)menuAudio1:(NSMenuItem *)sender{
    NSArray *menuArrSubTitlesIndexs = [player videoSubTitlesIndexes];
    player.currentVideoSubTitleIndex = [menuArrSubTitlesIndexs[1] intValue];
}

- (void)menuAudio2:(NSMenuItem *)sender{
    NSArray *menuArrSubTitlesIndexs = [player videoSubTitlesIndexes];
    player.currentVideoSubTitleIndex = [menuArrSubTitlesIndexs[2] intValue];
}

- (void)makeSubTitleMenu{
    NSLog(@"make SubTitle ...");
    NSMenu *subMenu = [[[NSMenu alloc] init] autorelease];
    NSArray *menuArrSubTitles = [player videoSubTitlesNames];
    NSLog(@"%ld", [menuArrSubTitles count]);
    if([menuArrSubTitles count] > 1){
        [subMenu addItemWithTitle:menuArrSubTitles[1] action:@selector(menuSubtitle1:) keyEquivalent:@""];
    }else{
    }
    [mSubtitles setSubmenu:subMenu];
}

- (void)menuSubtitle0:(NSMenuItem *)sender{
    //NSLog(@"manu0-0 %d", player.currentVideoSubTitleIndex);
    NSArray *menuArrSubTitlesIndexs = [player videoSubTitlesIndexes];
    player.currentVideoSubTitleIndex = [menuArrSubTitlesIndexs[0] intValue];
    //[player setCurrentVideoSubTitleIndex:menuArrSubTitlesIndexs[0]];
    //NSLog(@"manu0-1 %d", player.currentVideoSubTitleIndex);
    [player play];
    /*
    if(sender.state == NSControlStateValueOn){
        NSLog(@"Button On -> Off");
        sender.state = NSControlStateValueOff;
    }else{
        NSLog(@"Button Off -> On");
        sender.state = NSControlStateValueOn;
    }
     */
}

- (void)menuSubtitle1:(NSMenuItem *)sender{
    NSLog(@"manu1-0 %d", [player numberOfSubtitlesTracks]);
    //NSLog(@"manu1-0 %d", player.currentVideoSubTitleIndex);
    if(sender.state == NSControlStateValueOn){
        NSLog(@"Button On -> Off");
        sender.state = NSControlStateValueOff;
        player.currentVideoSubTitleIndex = -1;
    }else{
        NSLog(@"Button Off -> On");
        sender.state = NSControlStateValueOn;
        NSArray *menuArrSubTitlesIndexs = [player videoSubTitlesIndexes];
        player.currentVideoSubTitleIndex = [menuArrSubTitlesIndexs[1] intValue];
        //[player setCurrentVideoSubTitleIndex:menuArrSubTitlesIndexs[1]];
        
    }
    //NSLog(@"manu1-1 %d", player.currentVideoSubTitleIndex);
    NSLog(@"manu1-1 %d", [player numberOfSubtitlesTracks]);
    [player play];
}

- (void)play:(id)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strProgramURL = [ud objectForKey:@"strProgramURL"];
    NSWindowController *controller = [[NSWindowController alloc] initWithWindow:programWindow];
    [programWindow.contentView addSubview:programView];
    [programView setAutoresizingMask: NSViewHeightSizable|NSViewWidthSizable];
    //[programView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.20.9:8888/#!/program?type=GR"]]];
    NSLog(@"Program URL %ld", strProgramURL.length);
    if (strProgramURL.length == 0){
        strProgramURL = @"https://google.co.jp";
    }
    [programView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strProgramURL]]];
    [controller showWindow:nil];
}

- (void)pause:(id)sender
{
    NSLog(@"Sending pause message to media player...");
    [player pause];
}

- (void)mediaPlayerStateChanged:(NSNotification *)aNotification
{
    if(player.media){
        /*
        if([player.media metadataForKey:VLCMetaInformationNowPlaying].length== 0){
            [textLabel setStringValue:@""];
        }else{
            [textLabel setStringValue:[player.media metadataForKey:VLCMetaInformationNowPlaying]];
        }
         */
        [self makeAudioMenu];
        [self makeSubTitleMenu];
    }
}

- (void)setSPU:(id)sender
{
    if([self existChannel]){
    }else{
        NSLog(@"setSPU state. But, no channnel data.");
        return;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *dataUdd = [ud objectForKey:@"muArrChannel"];
    NSArray *arrUdCH = [NSKeyedUnarchiver unarchiveObjectWithData:dataUdd];
    NSString *strURL = arrUdCH[[[spuPopup selectedItem] tag]][@"strURL"];
    NSLog(@"strURL %@", strURL);
    player.media = [VLCMedia mediaWithURL:[NSURL URLWithString:strURL]];
    [player play];
    [ud setInteger:[spuPopup selectedItem] forKey:@"lastChannel"];
    //NSRect rect = NSMakeRect([window frame].origin.x, [window frame].origin.y, 960, 579);
    //[window setFrame:rect display:YES];

}

- (void)getChannel {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strMirakurunURL = [ud objectForKey:@"strMirakurunURL"];
    //NSString *strMirakurunURL = @"http://192.168.20.9:40772";
    NSURL *channelURL = [[NSURL URLWithString:strMirakurunURL] URLByAppendingPathComponent:@"/api/channels/"];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSArray *jsonResponse = nil;
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:channelURL
           completionHandler:^(NSData *data,
                               NSURLResponse *response,
                               NSError *error){
        if (error) {
            NSLog(@"get channel error: %@", error);
            dispatch_semaphore_signal(semaphore);
            return;
        }
        NSMutableArray *muArrUd = [[NSMutableArray alloc] init];
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dicChannel in jsonResponse){
            for (NSDictionary *dicDicChannel in dicChannel[@"services"]){
                NSString *strURL = [NSString stringWithFormat:@"%@/api/channels/%@/%@/services/%@/stream",
                                    strMirakurunURL, dicChannel[@"type"], dicChannel[@"channel"], dicDicChannel[@"serviceId"]];
                NSDictionary *dicUd = @{@"name":dicDicChannel[@"name"], @"type":dicChannel[@"type"],
                    @"strURL":strURL, @"enable":@YES};
                [muArrUd addObject:dicUd];
                break;
            }
        }
        NSData *dataUd = [NSKeyedArchiver archivedDataWithRootObject:muArrUd];
        [ud setObject:dataUd forKey:@"muArrChannel"];
        dispatch_semaphore_signal(semaphore);
        //?? kokodato dame? main thread janai???.
        //[self createChannel];
    }];
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return;
}
- (void)createChannel {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *dataUdd = [ud objectForKey:@"muArrChannel"];
    NSArray *arrUdCH = [NSKeyedUnarchiver unarchiveObjectWithData:dataUdd];
    [spuPopup removeAllItems];
    int indexCH = 0;
    for(NSDictionary *dicCH in arrUdCH){
        [spuPopup addItemWithTitle:dicCH[@"name"]];
        [[spuPopup lastItem] setTag:indexCH];
        indexCH++;
    }
}

- (IBAction)switchForeground:(NSMenuItem *)sender {
    if(sender.state == NSControlStateValueOn){
        NSLog(@"Stay in Front...");
        sender.state = NSControlStateValueOff;
        [window setLevel:NSNormalWindowLevel];
    }else{
        sender.state = NSControlStateValueOn;
        [window setLevel:NSFloatingWindowLevel];
    }
}

- (IBAction)removeALLsettings:(NSMenuItem *)sender {
    [self removeALLsettings];
}

- (void)removeALLsettings{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Remove ALL settings"];
    [alert addButtonWithTitle:@"DELTE"];
    [alert addButtonWithTitle:@"Cancel"];
    NSInteger button = [alert runModal];
    if (button == NSAlertFirstButtonReturn){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:@"strMirakurunURL"];
        [ud removeObjectForKey:@"strProgramURL"];
        [ud removeObjectForKey:@"muArrChannel"];
        [ud removeObjectForKey:@"lastChannel"];
        [ud removeObjectForKey:@"lastVolume"];
    } else if (button == NSAlertSecondButtonReturn){
    }
}

- (IBAction)inputTVschedule:(NSMenuItem *)sender {
    [self inputTVschedule];
}

- (void)inputTVschedule{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"TV Schedule Setting"];
    [alert setInformativeText:@"Please, input TV Schedule URL."];
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 48)];
    [input setStringValue:@"http://192.168.20.9:8888/#!/program?type=GR"];
    [alert setAccessoryView:input];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    NSInteger button = [alert runModal];
    if (button == NSAlertFirstButtonReturn){
        NSString *inputText = [input stringValue];
        NSLog(@"%@", inputText);
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:inputText forKey:@"strProgramURL"];
    } else if (button == NSAlertSecondButtonReturn){
    }
}

- (IBAction)inputMirakurun:(NSMenuItem *)sender {
    [self inputMirakurun];
}

- (void)inputMirakurun{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Mirakurun Setting"];
    [alert setInformativeText:@"Please, input mirakurun URL."];
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 48)];
    [input setStringValue:@"http://192.168.20.9:40772"];
    [alert setAccessoryView:input];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    NSInteger button = [alert runModal];
    if (button == NSAlertFirstButtonReturn){
        NSString *inputText = [input stringValue];
        NSLog(@"%@", inputText);
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:inputText forKey:@"strMirakurunURL"];
    } else if (button == NSAlertSecondButtonReturn){
    }
}

- (IBAction)snapShot:(NSButtonCell *)sender {
    NSLog(@"snapshot");
    //NSLog(@"videoView %lf x %lf", videoHolderView.frame.size.width, videoHolderView.frame.size.height);
    
    NSArray *ssDomainPaths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *ssDomainPath = [ssDomainPaths objectAtIndex:0];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyyMMDDHHMMSS";
    NSString *strDate = [df stringFromDate:[NSDate date]];
    NSString *ssStrPath = [ssDomainPath stringByAppendingFormat:@"/%@.jpg",strDate];
    
    [player saveVideoSnapshotAt:ssStrPath withWidth:1920 andHeight:1080];
    
}

- (IBAction)sliderVolume:(NSSlider *)sender {
    [player.audio setVolume:sender.integerValue];
    NSLog(@"%d", [player.audio volume]);
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:sender.integerValue forKey:@"lastVolume"];
}

- (BOOL)existChannel{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *dataUdd = [ud objectForKey:@"muArrChannel"];
    NSArray *arrUdCH = [NSKeyedUnarchiver unarchiveObjectWithData:dataUdd];
    NSLog(@"channel count %ld", [arrUdCH count]);
    if ([arrUdCH count] == 0){
        return NO;
    }
    return YES;
}

@end
