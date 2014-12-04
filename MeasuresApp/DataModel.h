//
//  DataModel.h
//  MeasuresApp
//
//  Created by Naota on 21/11/14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DataModel : NSObject
+ (DataModel*) Instance;

//  ВНИМАНИЕ! картинок еще нет!

// Poster
-(NSInteger) GetNearestAction;
// остальные данные извлекать из Places

// Categorys
-(NSArray*)categorys;

// Participants
- (void) setParticipantsFilter:(NSArray*) newFilter;
- (NSInteger) participantsCount;
- (NSString*) participantsNameAtIndex:(NSInteger)index;
- (id) participantsLogoAtIndex:(NSInteger) index;
- (id) participantsDetailsAtIndex:(NSInteger) index;
- (NSString*) participantsLogoURLAtIndex:(NSInteger) index;
- (id) participantsLinkAtIndex:(NSInteger) index;
- (NSString*) newsLogoURLAtIndex:(NSInteger) index;

// Sponsors
-(NSInteger)sponsorsCount;
-(NSString*)sponsorNameAtIndex:(NSInteger)index;
-(id)sponsorLogoAtIndex:(NSInteger)index;
-(id)sponsorDetailsAtIndex:(NSInteger)index;
- (NSString*) sponsorLogoURLAtIndex:(NSInteger) index;

//Places
-(NSInteger) placesCount;
-(NSString*) placeNameAtIndex:(NSInteger)index;
-(NSString*) placeSubtitleAtIndex:(NSInteger)index;
-(id) placeImageAtIndex:(NSInteger)index;
-(MKPointAnnotation*) placeMapPointAtIndex:(NSInteger)index;
-(id) placeDetailsURLAtIndex:(NSInteger)index;
-(NSDate*) placeDateAtIndex:(NSInteger)index;
-(NSString*) placeDateTextAtIndex:(NSInteger)index;
- (NSString*) placesImageURLAtIndex:(NSInteger) index;
-(NSString*) placeLinkAtIndex:(NSInteger)index;

// News
-(NSInteger) newsCount;
-(NSString*) newsTitleAtIndex:(NSInteger) index;
-(NSString*) newsSubtitleAtIndex:(NSInteger) index;
-(id) newsImageAtIndex:(NSInteger) index;
-(id) newsDetailsAtIndex:(NSInteger) index;
-(NSDate*)newsDateAtIndex:(NSInteger)index;

// Articles
-(NSString*)articlesByKey:(NSString*)key;
@end
