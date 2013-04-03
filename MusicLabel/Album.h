#import <CoreData/CoreData.h>

@class Artist;

@interface Album : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * released;
@property (nonatomic, retain) Artist *artist;

@end
