//
//  DataModel.m
//  MeasuresApp
//
//  Created by Naota on 21/11/14.
//  Copyright (c) 2014 vkCorporation. All rights reserved.
//

#import "DataModel.h"
#import <MapKit/MapKit.h>

#define const_Participants @"Participants"
#define const_Category @"Category"
#define const_Name @"Name"
#define const_LogoURL @"logoURL"
#define const_Details @"Details"
#define const_Sponsors @"Sponsors"
#define const_Places @"Places"
#define const_Subtitle @"Subtitle"
#define const_MapCoordinates @"longitude"
#define const_News @"News"
#define const_Date @"Date"

@interface DataModel()
{
    NSMutableDictionary* allData;
    NSArray* participantFilter;
    NSMutableArray* selectedParticipant;
    NSMutableArray* onDownloadImages;
    NSMutableDictionary* loadedImages;
}
-(UIImage*)imageByURL:(NSString*)url;
@end

@implementation DataModel

+ (DataModel*) Instance
{
    static DataModel* __instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc] init];
    });
    return __instance;
}

-(id) init
{
    if (self=[super init])
    {
        onDownloadImages = [NSMutableArray array];
        loadedImages = [NSMutableDictionary dictionary];
        
        allData = [[NSMutableDictionary alloc]init];
        [allData setObject:[NSMutableArray array] forKey:const_Participants];
        [allData setObject:[NSMutableArray array] forKey:const_Category];
        participantFilter = [NSArray array];
        [self setParticipantsFilter:participantFilter];
        [allData setObject:[NSMutableArray array] forKey:const_Sponsors];
        [allData setObject:[NSMutableArray array] forKey:const_Places];
        [allData setObject:[NSMutableArray array] forKey:const_News];
        // отключено до тестирования
        [self load];
//        [self save];
    }
    return self;
}

-(id) valueForm:(NSArray*)from index:(NSInteger)index key:(id)key
{
    if ([from count]<=index)
        return nil;
    
    return [[from objectAtIndex:index]objectForKey:key];
}

-(void)dealloc
{
    [self save];
}

#pragma mark -

-(void) addCategory:(NSString*)newCat
{
    if ([[allData objectForKey:const_Category]indexOfObject:newCat] == NSNotFound)
    {
        [[allData objectForKey:const_Category]addObject:newCat];
    }
}

-(NSArray*)categorys
{
    return [allData objectForKey:const_Category];
}

#pragma mark Poster

- (NSDate*) PosterStartDate
{
    return [[NSDate alloc]initWithTimeIntervalSinceNow:0];
}
- (id) PosterGetBanner
{
    return nil;
}

#pragma mark Participants

-(void) addParticipantWithName:(NSString*)name logo:(NSString*)logoURL category:(NSArray*)cats details:(id)details
{
    NSDictionary* newP = [NSDictionary dictionaryWithObjectsAndKeys:
                          name,const_Name,
                          logoURL,const_LogoURL,
                          cats,const_Category,
                          details,const_Details,
                          nil];
    [[allData objectForKey:const_Participants]addObject:newP];
    [self imageByURL:logoURL];
}

//
- (void) setParticipantsFilter:(NSArray*) newFilter
{
    NSArray* sortedFilter = [newFilter sortedArrayUsingSelector:@selector(compare:)];
    if (![participantFilter isEqualToArray:sortedFilter])
    {
        // Если фильтр пуст - возвращать всех
        if ([participantFilter count]==0)
        {
            selectedParticipant = [allData objectForKey:const_Participants];
        }
        // Иначе - сделать выборку
        else
        {
            [selectedParticipant removeAllObjects];
            for (NSDictionary* partic in [allData objectForKey:const_Participants]) {
                for (NSString* cat in [partic objectForKey:const_Category]) {
                    if ([sortedFilter containsObject:cat])
                    {
                        [selectedParticipant addObject: partic];
                        break;
                    }
                }
            }
        }
    }
}

- (NSInteger) participantsCount
{
    return [selectedParticipant count];
}

- (NSString*) participantsNameAtIndex:(NSInteger)index
{
    return [self valueForm:selectedParticipant index:index key:const_Name];
}

- (id) participantsLogoAtIndex:(NSInteger) index
{
    return [self imageByURL:[self valueForm:selectedParticipant index:index key:const_LogoURL]];
}

- (id) participantsDetailsAtIndex:(NSInteger) index
{
    return [self valueForm:selectedParticipant index:index key:const_Details];
}

#pragma mark Sponsors

-(void) addSponsorWithName:(NSString*)name logoURL:(NSString*)logoURL details:(id)details
{
    NSDictionary* newD = [NSDictionary dictionaryWithObjectsAndKeys:
                          name,const_Name,
                          logoURL,const_LogoURL,
                          details,const_Details,
                          nil];
    [[allData objectForKey:const_Sponsors]addObject:newD];
    [self imageByURL:logoURL];
}

-(NSInteger)sponsorsCount
{
    return [[allData objectForKey:const_Sponsors]count];
}

-(NSString*)sponsorNameAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Sponsors] index:index key:const_Name];
}

-(id)sponsorLogoAtIndex:(NSInteger)index
{
    return [self imageByURL:[self valueForm:[allData objectForKey:const_Sponsors] index:index key:const_LogoURL]];
}

-(id)sponsorDetailsAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Sponsors] index:index key:const_Details];
}

#pragma mark Places

-(void)addPlaceWith:(NSString*)name imageURL:(NSString*)imageURL description:(NSString*)description mapPoint:(MKPointAnnotation*) mapPoint details:(id)details
{
    NSDictionary* newD = [NSDictionary dictionaryWithObjectsAndKeys:
                          name,const_Name,
                          description,const_Subtitle,
                          imageURL,const_LogoURL,
                          mapPoint,const_MapCoordinates,
                          details,const_Details,
                          nil];
    [[allData objectForKey:const_Places]addObject:newD];
    [self imageByURL:imageURL];
}

-(NSInteger) placesCount
{
    return [[allData objectForKey:const_Places]count];
}

-(NSString*) placeNameAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Places] index:index key:const_Name];
}

-(NSString*) placeSubtitleAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Places] index:index key:const_Subtitle];
}

-(id) placeImageAtIndex:(NSInteger)index
{
    return [self imageByURL:[self valueForm:[allData objectForKey:const_Places] index:index key:const_LogoURL]];
}

-(MKPointAnnotation*) placeMapURLAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Places] index:index key:const_MapCoordinates];
}

-(id) placeDetailsURLAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_Places] index:index key:const_Details];
}

#pragma mark News

-(void) addNewsWithName:(NSString*)name imageURL:(NSString*)imageURL details:(id)details subtitle:(NSString*)subtitle date:(NSDate*)date
{
    NSDictionary* newD = [NSDictionary dictionaryWithObjectsAndKeys:
                          name,const_Name,
                          imageURL,const_LogoURL,
                          details,const_Details,
                          subtitle,const_Subtitle,
                          date,const_Date,
                          nil];
    
    [[allData objectForKey:const_News]addObject:newD];
    [self imageByURL:imageURL];
}

-(NSInteger) newsCount
{
    return [[allData objectForKey:const_News]count];
}

-(NSString*) newsTitleAtIndex:(NSInteger) index
{
    return [self valueForm:[allData objectForKey:const_News] index:index key:const_Name];
}
-(NSString*) newsSubtitleAtIndex:(NSInteger) index
{
    return [self valueForm:[allData objectForKey:const_News] index:index key:const_Subtitle];
}
-(id) newsImageAtIndex:(NSInteger) index
{
    return [self imageByURL:[self valueForm:[allData objectForKey:const_News] index:index key:const_LogoURL]];
}
-(id) newsDetailsAtIndex:(NSInteger) index
{
    return [self valueForm:[allData objectForKey:const_News] index:index key:const_Details];
}
-(NSDate*)newsDateAtIndex:(NSInteger)index
{
    return [self valueForm:[allData objectForKey:const_News] index:index key:const_Date];
}

#pragma mark -

-(NSDictionary*) getDataForUrl:(NSString*)urlString
{
    NSURL* url = [[NSURL alloc]initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
//        if (error!=nil)
//        {
//            NSLog(@"Error in NSURLConnection for %@ / %@",urlString,[error description]);
//            return nil;
//        }
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:oResponseData options:0 error:&localError];
    
//    if (localError != nil)
//    {
//        if (error!=nil)
//        {
//            NSLog(@"Error in NSJSONSerialization for %@ / %@",urlString,[error description]);
//            return nil;
//        }
//        return nil;
//    }
    
//    [parsedObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"%@ -> %@",[key description], [[obj class]description]);
//    }];
    return parsedObject;
}

-(NSString*)urlToFileName:(NSString*)url
{
    url = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    url = [url stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    return  url;
}

-(UIImage*)imageByURL:(NSString*)url
{
//    NSString* fileName = [self urlToFileName:url];
    UIImage* answer = [loadedImages objectForKey:url];
    if (answer)
        return answer;
    
    if ([self loadImageFromDisk:url])
    {
        answer = [loadedImages objectForKey:url];
        if (answer)
            return answer;
    }
    
    [self downloadImage:url];
    
    return nil;
}

-(void)saveImage:(UIImage*)image withURL:(NSString*)url
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSData * binaryImageData = UIImagePNGRepresentation(image);
    
    if(! [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:[self urlToFileName:url]] atomically:YES])
    {
        NSLog(@"can't save file %@/%@",basePath,[self urlToFileName:url]);
    }
}

-(BOOL)loadImageFromDisk:(NSString*)url
{
    NSString* filename = [self urlToFileName:url];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *outputPath = [documentsDirectory stringByAppendingPathComponent:filename ];
    
//    NSLog(@"outputPath: %@", outputPath);
    UIImage *theImage = [UIImage imageWithContentsOfFile:outputPath];
    
    if (theImage) {
        [loadedImages setObject:theImage forKey:url];
        return YES;
    }
    return NO;
}

-(void)downloadImage:(NSString*)url
{
    if ([onDownloadImages indexOfObject:url]!=NSNotFound)
        return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           if (imageData!=nil)
                           {
                               [onDownloadImages removeObject:url];
                               [self saveImage: [UIImage imageWithData:imageData] withURL:url];
                           }
                       });
                   });
}

-(void)load
{
    // Load Participant and Sponsors
    
    NSDictionary *parsedObject = [self getDataForUrl:@"http://bitrix.besaba.com/request/members.php?command=allShow"];
    
    for (int i=0; i<[[parsedObject objectForKey:@"id"]count]; i++) {
        NSString* name = [parsedObject objectForKey:@"name"][i];
        NSString* logoURL = [parsedObject objectForKey:@"logo"][i];
        NSString* categorys = [parsedObject objectForKey:@"category"][i];
        NSArray* categotysArr = [categorys componentsSeparatedByString:@", "];
        NSString* details =[parsedObject objectForKey:@"description"][i];
        
        int indexOfSponsorCat = [categotysArr indexOfObject:@"спонсоры"];
        
        if (indexOfSponsorCat!=NSNotFound)
        {
            [self addSponsorWithName:name logoURL:logoURL details:details];
            
            NSMutableArray* tmpArr = [NSMutableArray arrayWithArray:categotysArr];
            [tmpArr removeObjectAtIndex:indexOfSponsorCat];
            categotysArr = tmpArr;
        }
        
        [self addParticipantWithName:name logo:logoURL category:categotysArr details:details];
    }
    
    // Load Categorys
    parsedObject = nil;
    parsedObject = [self getDataForUrl:@"http://bitrix.besaba.com/request/category.php?command=allShow"];
//    [parsedObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"%@ -> %@",[key description], [[obj class]description]);
//    }];
    NSArray* cats = [parsedObject objectForKey:@"cat_name"];
    for (NSString* cat in cats) {
        if (![cat isEqualToString:@"спонсоры"])
            [self addCategory:cat];
    }

    // Load Locations
    parsedObject = nil;
    parsedObject = [self getDataForUrl:@"http://bitrix.besaba.com/request/locations.php?command=allShow"];
    
//    [parsedObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"%@ -> %@",[key description], [[obj class]description]);
//    }];
    
    for (int i=0; i<[[parsedObject objectForKey:@"id"]count]; i++) {
        NSString* name = [parsedObject objectForKey:@"name"][i];
        NSString* subtitle = [parsedObject objectForKey:@"description"][i];
        NSString* latitude =[parsedObject objectForKey:@"latitude"][i];
        NSString* longitude =[parsedObject objectForKey:@"longitude"][i];
        CLLocationDegrees fLatitude = [latitude doubleValue];
        CLLocationDegrees fLongitude = [longitude doubleValue];

        MKPointAnnotation* newPlace = [[MKPointAnnotation alloc]init];
        newPlace.coordinate = CLLocationCoordinate2DMake(fLatitude, fLongitude);
        newPlace.title = name;
        newPlace.subtitle = subtitle;
        
        [self addPlaceWith:name imageURL:nil description:subtitle mapPoint:newPlace details:@""];
    }
    
    /// Load News and other Articles
    
    parsedObject = nil;
    parsedObject = [self getDataForUrl:@"http://bitrix.besaba.com/request/articles.php?command=allShow"];
    
//    [parsedObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        NSLog(@"%@ -> %@",[key description], [[obj class]description]);
//    }];
    
    for (int i=0;i<[[parsedObject objectForKey:@"id"]count];i++)
    {
        NSString* title = [parsedObject objectForKey:@"title"][i];
        NSString* subtitle = [parsedObject objectForKey:@"description"][i];
        NSString* imageURL = [parsedObject objectForKey:@"image"][i];
        NSString* dateStr = [parsedObject objectForKey:@"date"][i];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        
        NSString* text = [parsedObject objectForKey:@"text"][i];
        
        /*@try {
            date = [dateFormatter dateFromString:dateStr];
        }
        @catch (NSException *exception) {
            date = nil;
        }


        if(!date || [dateStr isKindOfClass:[NSNull class]])
            date = [NSDate date];
        
        NSString* text = [parsedObject objectForKey:@"text"][i];
        
        if(!title || [title isKindOfClass:[NSNull class]])
            title = @"title test";
        if(!subtitle || [subtitle isKindOfClass:[NSNull class]])
            subtitle = @"subtitle test";
        if(!imageURL)
            imageURL = @"http://s0.wp.com/wp-content/themes/pub/motion/images/genericlogo.png?m=1391151707g";
        if(!dateStr || [dateStr isKindOfClass:[NSNull class]])
            dateStr = @"11-12-2000";
        if(!text || [text isKindOfClass:[NSNull class]])
            text = @"text Test";
         */
        
        [self addNewsWithName:title imageURL:imageURL details:text subtitle:subtitle date:date];
    }
}

-(void)save
{
    
}

@end
