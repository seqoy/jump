/*
 * copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "JPLoggerMetadata.h"

@implementation JPLoggerMetadata
@synthesize message, fileName, domain, className, methodName, lineNumber, exception, logLevel, assertion, caller;

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Init Methods.
- (id) init {
	self = [super init];
	if (self != nil) {
		// Initialize all as empty values (not nil values).
		[self validate];
	}
	return self;
}


////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(id)init {
	return [[self alloc] init];
}

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
+(id)initWithMessage:(id)variableList, ... {
	JPLoggerMetadata *anInstance = [self init];
	
	// Set formatted message.
	va_list args;
	[anInstance setMessage:variableList, args];
	return anInstance;
}

////////// ////////// ////////// //

////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
#pragma mark -
#pragma mark Methods.
////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// ////////// 
-(void)setMessage:(id)variableList, ... {
    // Arguments.
    va_list args;
    
	// If nil, doesn't set.
	if ( variableList == nil || args == nil)
		return;
	
	// Set Message formatted.
	message = [NSString stringWithFormat:variableList, args];
}

////////// ////////// ////////// ////////// ////////// ////////// ////
-(NSString*)prettyMethod {
	return [NSString stringWithFormat:@"[%@ %@]", self.className, self.methodName];
}

///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)validate {
	if ( message == nil )
		[self setMessage:@"Unknown"];
	if ( fileName == nil )
		self.fileName = @"Unknown";
	if ( className == nil )
		self.className = @"Unknown";
	if ( methodName == nil )
		self.methodName = @"Unknown";
}

@end
