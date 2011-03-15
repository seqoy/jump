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

/*! \file JPDBManagerDefinitons.h
	\link JPDBManager Database Manager\endlink and \link JPDBManagerAction Database Actions\endlink definitions.
 */

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Exceptions
////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
// This kind of exception is thrown when is impossible to perform an Database Action.
#define JPDBManagerActionException @"JPDBManagerActionException"

// This kind of exception is thrown when is impossible to start the Core Data environment.
#define JPDBManagerStartException @"JPDBManagerStartException"

// Invalid initiator Exception.
#define JPDBInvalidInitiator @"JPDBInvalidInitiator"

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Notifications Keys

// The Database Manager post an NSNotification of this type when some error ocurr performing some operation.
#define JPDBManagerErrorNotification @"JPDBManagerErrorNotification"

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 
#pragma mark -
#pragma mark Shortcuts Macro-Functions.

// Convenient macro shortcut that returns an JPDBManagerAction instance. 
#define JPDatabaseManager [[JPDBManagerSingleton sharedInstance] getDatabaseAction]

////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 

/*! \mainpage JUMP Database Programming Guide
 
 <b>JUMP Database Module</b> is an collection of classes that are wrappers and facades around the <a href="http://developer.apple.com/library/mac/#documentation/cocoa/conceptual/CoreData/cdProgrammingGuide.html">Apple Core Data Framework</a>.<br>
 <br>
 You should have at least an basic experiencie with this powerful Apple framework to fully understand this module,
 he doesn't abstract or replace the Core Data, it just make your life more easy.<br>
 <br>
 The main component of this module are the \link JPDBManager Database Manager\endlink. The manager center the main Core Data components in a single class
 and facilitate a collection of methods to perform main tasks around it. Also the manager could be used as a \link JPDBManagerSingleton Singleton Instance\endlink
 facilitating even more your database operations.
 
 This diagram shows all components of the Database Manager operations and his components.<br>
 <br>
 \image html JUMPDatabaseDiagrams.jpg
 
 <h2>Learn more about this module in the following sections:</h2>
 - \subpage basic_uses
 - \subpage errors
 - \subpage queries
 */



////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 


/*! \page errors Handling Errors
 There are two types of errors that the \link JPDBManager Database Manager\endlink let you known.
 
 \section fatal_errors Fatal Errors or Exceptions
 This is are errors that will prevent the <b>Database Manager</b> or your application to work correctly. On most part of cases
 you're trying to retrieve some data that doesn't exist or something like that. So an exception (<b>NSException</b>) is raised and 
 if isn't catched will interrupt your application. You always can use an <b>try..catch</b> block to avoid that.
 
 This is are the exceptions raised by the Manager. This exceptions are defined on JPDBManagerDefinitions.h file.
 
 \subsection JPDBManagerActionException JPDBManagerActionException
 This kind of exception is raised when is impossible to perform an \link JPDBManagerAction Database Action\endlink.
 
 \subsection JPDBManagerStartException JPDBManagerStartException
 This kind of exception is raised when is impossible to start the <b>Core Data</b> environment.
 
 \subsection JPDBInvalidInitiator JPDBInvalidInitiator
 This kind of exception is raised when you try to use some 'init' method that is protected. From an Abstract or an Singleton Class for example.
 
 \section errors_section Errors
 This is are errors that doesn't prevent the <b>Database Manager</b> or your application to work correctly. If you doesn't handle
 this errors they will be logged to the console, nothing else.
 
 To handle this errors you should sign to the <b>NSNotificationCenter</b> with the <b>JPDBManagerErrorNotification</b> Key 
 to receive detailed information. This Key is defined in JPDBManagerDefinitions.h file.<br> 
 <br>
 The <b>Database Manager</b> post an <b>NSNotification</b> when some error ocurr performing one operation. <br>
 <br>
 The <b>NSNotification</b> object encapsulate an <b>NSError</b> with the cause and description. 
 * You can retrieve the manager that generates the error acessing the <b>JPDBManagerErrorNotification</b> Key on the <b>userInfo</b> dictionary.
 */



////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 


/*! \page queries Performing Queries
 The <b>Database Manager</b> post an <b>NSNotification</b> when some error ocurr performing one operation.
 Sign to the <b>NSNotificationCenter</b> with the <b>JPDBManagerErrorNotification</b> Key to receive detailed information.<br>
 <br>
 The <b>NSNotification</b> object encapsulate an <b>NSError</b> with the cause and descrption. 
 * You can retrieve the manager that generates he error acessing the <b>JPDBManagerErrorNotification</b> Key on the <b>userInfo</b> dictionary.
 */


////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// ////// 

/*! \page basic_uses Basic Uses
 
 This page show some basic examples of usage for the <b>JUMP Database Module</b>.<br>
 <br>
 On our examples we presume that you have your Core Data models created. See <a href="http://developer.apple.com/library/mac/#documentation/cocoa/conceptual/CoreData/cdProgrammingGuide.html">Introduction to Core Data Programming Guide</a> <br>
 to learn more about it.<br>
 <br>
 
 
 
 
 \section init_manager Initializing the Database Manager
 The first step to start to work with the \link JPDBManager Database Manager\endlink is initialize the all system.
 \code
 [[JPDBManagerSingleton sharedInstance] startCoreData];
 \endcode
 The above code perform a lot of tasks. He initiate the full Core Data model and create the persistent stores if needed. We're using an
 <b>Singleton Instance</b> of the Manager. You always can initiate one regular instance, but in the most common cases you will use this way.
 
 
 
 
 \section db_action Performing Database Actions
 \copydetails JPDBManagerAction
 
 
 
 
 \section commit_operation Commiting operations
 <b>Core Data</b> never perform operations directly to the <b>Persistent Store</b>. It maintains one memory model and you need to 
 save (commit) your changes. You can configure the <b>Database Manager</b> to automatically commit every operation as default and also
 you can configure each <b>Database Action</b> case by case.
 \code
 [[JPDBManagerSingleton sharedInstance] setAutomaticallyCommit:YES];
 \endcode
 Now all <b>Database Action</b> will be committed immediattelly. This is means that every <b>Database Action</b> instance returned 
 by the <b>getDatabaseAction:</b> method will be configured with this setting. Now you can use the approach showed in the \ref db_action
 section to configure some specific action with different setting.<br>
 <br>
 To manually commit all pending operations to the <b>Persistent Store</b> is very simple:
 \code
 [[JPDBManagerSingleton sharedInstance] commit];
 \endcode
 If fore some reason the commit operation fails one <b>NSNotificaton</b> is posted. See \ref errors for more inforation.
 
 
 
 
 
 \section query_operation Querying Database
 You will enconter a huge number of convenient methods to perform simple and very complex queries to the database. See \ref queries for
 more information. Here are some examples of some query operations:
 \code
 // Query all data from 'MyEntity'.
 NSArray *allData = [JPDatabaseManager queryAllDataFromEntity:@"MyEntity"];
 
 // Query data using the 'MyFilter" Fetch Template and ordering by 'id'.
 NSArray *allData = [JPDatabaseManager queryEntity:@"MyEntity" withFetchTemplate:@"MyFilter" orderWithKey:@"id"];
 \endcode
 You can also mount your <b>Database Actions</b> on a more custom fashion:
 \code
 JPDBManagerAction *anAction = [[JPDBManagerSingleton sharedInstance] getDatabaseAction];
 
 // Apply the Entity.
 [anAction applyEntity:@"MyEntity"];
 
 // Limit to 20 rows.
 [anAction setStartFetchInLine:0 setLimitFetchResults:20];
 
 // Order by 'name' in desceding order.
 [[anAction applyOrderKey:@"id"] setAscendingOrder:NO];
 
 // Perform the action.
 NSArray *first20rows = [anAction runAction];
 \endcode 
 There you go, the <b>Database Action</b> is very flexible to configure and also very convenient to use. Note that all <b>apply...</b> methods
 return the <b>self</b> instance. So you can nest many apply methods on the same line.<br>
 <br>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
