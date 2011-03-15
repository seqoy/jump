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
#import <Foundation/Foundation.h>
#import "JPDBManager.h"

/**
 * \class JPDBManagerSingleton 
 * Singleton instance of \link JPDBManager Database Manager\endlink that handle the <b>Core Data Environment</b>.
 * Note that you should initiate this class using the #sharedInstance method, if you try to initate using some of the JPDBManager init methods 
 * an \ref JPDBInvalidInitiator exception will be raised. See \ref errors for more informations.<br>
 * <br>
 * \copydetails JPDBManager
 */
@interface JPDBManagerSingleton : JPDBManager {}

/** 
 * Init Singleton Class Instance.
 * This Method Initialize this class and/or return one singleton instance of it.
 */ 
+(JPDBManagerSingleton*)sharedInstance;  

@end
