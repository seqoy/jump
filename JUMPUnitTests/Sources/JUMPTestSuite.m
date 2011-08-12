/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org ) 
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
#import <GHUnitIOS/GHUnit.h> 
#import <GHUnitIOS/GHTestSuite.h>

//////////// //////////// //////////// /////
/**
 * JUMP Database Module Unit Tests
 */
@interface JUMPTestSuite : GHTestSuite {}
@end  

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
@implementation JUMPTestSuite

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Test Case Group Methods.
////// //////////// //////////////// //////////// //////////
// JUMP Logger Test Cases.
-(void)jumpLoggerCase {
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPLog4CocoaTest" delegate:nil]]; 
	
	//////// ////// ////// ////// ////// ////// ////// ////// //
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPNSLogTest" delegate:nil]]; 
}	

////// //////////// //////////////// //////////// //////////
// JUMP User Interface Test Cases.
-(void)jumpUnitTestingCases {
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPColorTests" delegate:nil]]; 
}

////// //////////// //////////////// //////////// //////////
// JUMP Database Test Cases.
-(void)jumpDatabaseTestingCases {
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDBManagerTests" delegate:nil]]; 
	
	//////// ////// ////// ////// ////// ////// ////// ////// //
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDBManagerSingletonTests" delegate:nil]]; 

	//////// ////// ////// ////// ////// ////// ////// ////// //
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDBManagerActionTests" delegate:nil]]; 
}

////// //////////// //////////////// //////////// //////////
// JUMP Database Test Cases.
-(void)jumpDataCase {
//	[self addTestGroup:
//	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDataXMLTests" delegate:nil]]; 
	
//	[self addTestGroup:
//	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDataSyncConfiguratorTest" delegate:nil]];
//	
//	[self addTestGroup:
//	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDataPopulator" delegate:nil]];
//	
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDataAtomFeedTests" delegate:nil]];

	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPDataRSSFeedTests" delegate:nil]]; 

}

////// //////////// //////////////// //////////// //////////
// JUMP Database Test Cases.
-(void)jumpNetworkCase {
	[self addTestGroup:
	[GHTestGroup testGroupFromTestCaseClassName:@"JUMPXMLDecoderTest" delegate:nil]]; 
}

//////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// //////////// 
#pragma mark -
#pragma mark Init Test Suite.
////// //////////// //////////////// //////////// //////////
- (id)initWithName:(NSString *)name delegate:(id<GHTestDelegate>)delegate {
	[super initWithName:name delegate:delegate];
	if (self != nil) {
		////// //////////// //////////////// //////////// //////////
		// JUMP Data Test Cases.
		//[self jumpDataCase];

		////// //////////// //////////////// //////////// //////////
		// JUMP Network Test Cases.
		//[self jumpNetworkCase];
		
		////// //////////// //////////////// //////////// //////////
		// JUMP Logger Test Cases.
		[self jumpLoggerCase];
		
		////// //////////// //////////////// //////////// //////////
		// JUMP User Interface Test Cases.
		//[self jumpUnitTestingCases];

		////// //////////// //////////////// //////////// //////////
		// JUMP User Interface Test Cases.
		//[self jumpDatabaseTestingCases];
	}
	return self;
}

@end
