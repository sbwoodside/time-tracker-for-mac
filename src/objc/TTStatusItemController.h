//
//  TTStatusItemController.h
//
//  Created by Aaron VonderHaar on 2009-08-02.
//  Copyright (c) 2009 Aaron VonderHaar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTApplicationState.h"
#import "TTResources.h"
#import "NIStatusItem.h"
#import "NIImage.h"

@protocol TTStatusItemControllerDelegate
- (void)statusItemClicked:(NSStatusItem *)statusItem;
- (TTApplicationState *)applicationState;
@end

@interface TTStatusItemController : NSObject
{
  id<TTStatusItemControllerDelegate> _delegate;
  
  NSStatusItem * _statusItem;
  NSImage * _image;
  
  NSImage * _playItemImage;
  NSImage * _playItemHighlightImage;
  NSImage * _stopItemImage;
  NSImage * _stopItemHighlightImage;
}

- (id)initWithStatusItem:(NSStatusItem *)statusItem
               resources:(id<TTResources>)resources
                delegate:(id<TTStatusItemControllerDelegate>)delegate;
- (void)update;

@end
