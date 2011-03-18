
/*
 * Copyright (c) 2011 - SEQOY.org and Paulo Oliveira ( http://www.seqoy.org )
 *
 * Licensed under the Apache License, Version 2.0 (the "License") {  };
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
#import "JPLog4CocoaLogger.h"
#import "JPLog4CocoaFactory.h"

@implementation JPLog4CocoaLogger

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
#pragma mark -
#pragma mark Getters and Setters.
///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(id)getKeyForLog {
	return keyForLog;
}

////////// ////////// ////////// //////////
-(void)setKeyForLog:(id)anKey {
	keyForLog = (Class)anKey;
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)setLevel:(JPLoggerLevels)desiredLevel {
	
	// Level.
	L4Level *anLevel = [JPLog4CocoaFactory convertJPLevel:desiredLevel];;
	
	// Set the log level for this specific class.
	[[L4Logger loggerForClass:(Class)[self getKeyForLog]] setLevel:anLevel];
}

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(JPLoggerLevels)currentLevel {
	// Compiler condition to disable all logs.
	#ifndef JPLOGGER_DISABLE_ALL
		
		// Current level for specific class.
		L4Level *anLevel = [[L4Logger loggerForClass:(Class)[self getKeyForLog]] level];
		
		// Convert and return.
		return [JPLog4CocoaFactory convertL4Level:anLevel];
	
	///////////// ///////////// /////////
	#else
		return JPLoggerOffLevel;
	#endif
}

// Compiler condition to disable all logs.
#ifndef JPLOGGER_DISABLE_ALL

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)debug:(id)variableList, ... { 
    va_list args;
	if([[L4Logger loggerForClass:(Class)[self getKeyForLog]] isDebugEnabled]) 
		log4Log(L4_LOG([L4Level debug], nil), variableList,args);

}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)info:(id)variableList, ...  { 
    va_list args;
	if([[L4Logger loggerForClass:(Class)[self getKeyForLog]] isInfoEnabled]) 
		log4Log(L4_LOG([L4Level info], nil), variableList,args);
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)warn:(id)variableList, ...  { 
    // Simply redirect parameters.
    va_list args;
    log4Warn( variableList, args );
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)error:(id)variableList, ...  { 
    // Simply redirect parameters.
    va_list args;
    log4Error( variableList, args );
}; 

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)fatal:(id)variableList, ...  {  
    // Simply redirect parameters.
    va_list args;
    log4Fatal( variableList, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
    // Simply redirect parameters.
    va_list args;
    log4DebugWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...   { 
    // Simply redirect parameters.
    va_list args;
    log4InfoWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4WarnWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4ErrorWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
-(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...   {  
    // Simply redirect parameters.
    va_list args;
    log4FatalWithException( variableList, anException, args );
};

///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// ///////////// 
// Compiler condition to disable all logs.
#else

	-(void)debug:(id)variableList, ... { /// Disabled };
	-(void)info:(id)variableList, ...  { /// Disabled }; 
	-(void)warn:(id)variableList, ...  { /// Disabled }; 
	-(void)error:(id)variableList, ...  { /// Disabled }; 
	-(void)fatal:(id)variableList, ...  { /// Disabled };
	-(void)debugWithException:(NSException*)anException andMessage:(id)variableList, ...   { /// Disabled };
	-(void)infoWithException:(NSException*)anException andMessage:(id)variableList, ...   { /// Disabled };
	-(void)warnWithException:(NSException*)anException andMessage:(id)variableList, ...   { /// Disabled };
	-(void)errorWithException:(NSException*)anException andMessage:(id)variableList, ...   { /// Disabled };
	-(void)fatalWithException:(NSException*)anException andMessage:(id)variableList, ...   { /// Disabled };

#endif

@end
