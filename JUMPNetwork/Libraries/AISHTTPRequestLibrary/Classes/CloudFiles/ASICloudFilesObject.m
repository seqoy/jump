//
//  ASICloudFilesObject.m
//
//  Created by Michael Mayo on 1/7/10.
//

#import "ASICloudFilesObject.h"


@implementation ASICloudFilesObject

@synthesize name, hash, bytes, contentType, lastModified, data, metadata;

+ (id)object {
	ASICloudFilesObject *object = [[self alloc] init];
	return object;
}

@end
