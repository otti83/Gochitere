/*****************************************************************************
 * test: Controller
 *****************************************************************************
 * Copyright (C) 2007-2012 Pierre d'Herbemont and VideoLAN
 *
 * Authors: Pierre d'Herbemont
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

#import <Cocoa/Cocoa.h>
#import <VLCKit/VLCKit.h>
#import <WebKit/WebKit.h>

@interface Controller : NSObject
{
    IBOutlet id window;
    IBOutlet NSView *videoHolderView;
    IBOutlet id spuPopup;
    IBOutlet NSSlider *sliderVolume;
    IBOutlet NSButton *snapshot;
    IBOutlet NSWindow *programWindow;
    IBOutlet WKWebView *programView;
    IBOutlet NSMenuItem *inputMirakurun;
    IBOutlet NSMenuItem *inputTVschedule;
    IBOutlet NSMenuItem *removeALLsettings;
    IBOutlet NSMenuItem *switchForeground;
    IBOutlet NSTextField *textLabel;
    IBOutlet NSMenuItem *mPlaying;
    IBOutlet NSMenuItem *mSubtitles;
    IBOutlet NSMenuItem *mAudio;
    
    VLCVideoView * videoView;
    VLCMediaPlayer *player;
}
- (void)awakeFromNib;
- (void)play:(id)sender;

- (void)getChannel;
- (void)createChannel;
- (void)removeALLsettings;
- (void)inputMirakurun;
- (void)inputTVschedule;
- (BOOL)existChannel;
- (void)makeSubTitleMenu;

- (IBAction)setSPU:(id)sender;
- (IBAction)sliderVolume:(NSSlider *)sender;
- (IBAction)snapShot:(NSButtonCell *)sender;
- (IBAction)inputMirakurun:(NSMenuItem *)sender;
- (IBAction)removeALLsettings:(NSMenuItem *)sender;
- (IBAction)switchForeground:(NSMenuItem *)sender;
- (IBAction)inputTVschedule:(NSMenuItem *)sender;

@end
