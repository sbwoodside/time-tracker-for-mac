//
//  TTStatusItemController.m
//
//  Created by Aaron VonderHaar on 2009-08-02.
//  Copyright (c) 2009 Aaron VonderHaar. All rights reserved.
//

#import "TTStatusItemController.h"

@implementation TTStatusItemController

- (id)initWithStatusItem:(NSStatusItem *)statusItem
               resources:(id<TTResources>)resources
                delegate:(id<TTStatusItemControllerDelegate>)delegate;
{
  self = [super init];
  _statusItem = [statusItem retain];
  _delegate = delegate;
  
  _playItemImage = [[NSImage imageNamed:@"playitem.png"] retain];
  _playItemHighlightImage = [[NSImage imageNamed:@"playitem_hl.png"] retain];
  _stopItemImage = [[NSImage imageNamed:@"stopitem.png"] retain];
  _stopItemHighlightImage = [[NSImage imageNamed:@"stopitem_hl.png"] retain];
  
  [_statusItem setTarget: self];
  //[_statusItem setMenu:statusItemMenu];
  [_statusItem setAction:@selector(clicked:)]; // @selector (clickedStartStopTimer:)];
  
  [_statusItem setToolTip:[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey]];
  [_statusItem setHighlightMode:NO];
  
  return self;
}

- (void)dealloc
{
  [_playItemImage release];
  [_playItemHighlightImage release];
  [_stopItemImage release];
  [_stopItemHighlightImage release];
  [_statusItem release];
  [super dealloc];
}

- (void)update
{
  TTApplicationState * appState = [_delegate applicationState];
  assert(appState != nil);
  assert(_playItemImage != nil);
  assert(_stopItemImage != nil);
  if ( appState.timerRunning == NO )
  {
    [_statusItem setImage:_playItemImage];
    //[statusItem setTitle:@"Start"];
    _image = _playItemImage;
    //[statusItem setAlternateImage:playItemHighlightImage];
  }
  else
  {
    [_statusItem setImage:_stopItemImage];
    //[statusItem setTitle:@"Stop"];
    _image = _stopItemImage;
    //[statusItem setAlternateImage:stopItemHighlightImage];
  }
}

- (void)clicked:(NSStatusItem *)statusItem; {
  [_delegate statusItemClicked:statusItem];
  [self update];
}

@end
