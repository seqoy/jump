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

#import "JPPipelineHandler.h"
#import "JPPipelineEvent.h"
#import "JPPipelineSink.h"
#import "JPDefaultHandlerContext.h"
#import "JPPipelineDownstreamHandler.h"
#import "JPPipelineUpstreamHandler.h"
#import "JPPipelineExceptionEvent.h"
#import "JPPipelineException.h"

#import "JPLogger.h"

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Notifications.
#define JPPipelineNotify @"JPPipelineNotify"
#pragma mark -
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/**
 \nosubgrouping 
 \brief  JPPipeline is implementation of an presentation-tier request handling mechanism to receive many different types of requests.
 \copydoc the_pipeline
 */ 
@interface JPPipeline : NSObject {
	JPDefaultHandlerContext* head;
	JPDefaultHandlerContext* tail;
	NSMutableDictionary *contextObjectsMap;
	NSMutableSet *finalObjects;
	
	//// //// //// //// //// //// //// //// //// //// //// /
	id<JPPipelineSink> sink;
		    
    //// //// //// //// //// //// //// //// //// //// //// /
	// Overall Progress of the pipeline processing.
    NSNumber* progress;
    
    // Handlers progress priority.
    NSMutableArray* sectionedProgress;

}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark Properties.
/**
 An \link transporter_page I|O Transporter\endlink implementation.
 \see JPPipelineSink and \ref transporter_page for more information.
 */
@property (retain) id<JPPipelineSink>sink;

/**
 * Overal progress of the all pipeline process. You can check the <tt>progress</tt> property of 
 * some individual handler to see his progress.
 */ 
@property (readonly) NSNumber* progress;

//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Init Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Init Methods
 */
///@{
/**
 * Init the pipeline.
 */
+(id)init;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Add Handler Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Add Handler Methods
 */
///@{

/**
 * Inserts a Handler at the first position of this pipeline.
 *
 * @param name     the name of the handler to insert first
 * @param handler  the handler to insert first
 */
-(void)addFirst:(NSString*)name withHandler:(id<JPPipelineHandler>)handler;

/**
 * Inserts a Handler at the first position of this pipeline.
 *
 * @param name     the name of the handler to insert first
 * @param handler  the handler to insert first
 * @param priority  A number from 0 to 10 that defines what priority this handler has on the overall progress calculation.
 */
-(void)addFirst:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority;

/**
 * Appends a Handler at the last position of this pipeline.
 *
 * @param name     the name of the handler to append
 * @param handler  the handler to append
 */
-(void)addLast:(NSString*)name withHandler:(id<JPPipelineHandler>)handler;

/**
 * Appends a Handler at the last position of this pipeline.
 *
 * @param name     the name of the handler to append
 * @param handler  the handler to append
 * @param priority  A number from 0 to 10 that defines what priority this handler has on the overall progress calculation.
 */
-(void)addLast:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority;

/**
 * Inserts a JPPipelineHandler before an existing handler of this
 * pipeline.
 *
 * @param baseName  the name of the existing handler
 * @param name      the name of the handler to insert before
 * @param handler   the handler to insert before
 *
 */
-(void)addBefore:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler;

/**
 * Inserts a JPPipelineHandler before an existing handler of this
 * pipeline.
 *
 * @param baseName  the name of the existing handler
 * @param name      the name of the handler to insert before
 * @param handler   the handler to insert before
 * @param priority  A number from 0 to 10 that defines what priority this handler has on the overall progress calculation.
 */
-(void)addBefore:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority;

/**
 * Inserts a JPPipelineHandler after an existing handler of this
 * pipeline.
 *
 * @param baseName  the name of the existing handler
 * @param name      the name of the handler to insert after
 * @param handler   the handler to insert after
 *
 */
-(void)addAfter:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler;

/**
 * Inserts a JPPipelineHandler after an existing handler of this
 * pipeline.
 *
 * @param baseName  the name of the existing handler
 * @param name      the name of the handler to insert after
 * @param handler   the handler to insert after
 * @param priority  A number from 0 to 10 that defines what priority this handler has on the overall progress calculation.
 */
-(void)addAfter:(NSString*)baseName withName:(NSString*)name withHandler:(id<JPPipelineHandler>)handler withProgressPriority:(NSInteger)priority;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Remove Handler Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Add Handler Methods
 */
///@{

/**
 * Removes the specified JPPipelineHandler from this pipeline.
 */
-(void)removeByHandler:(id<JPPipelineHandler>)handler;

/**
 * Removes the JPPipelineHandler with the specified name from this
 * pipeline.
 *
 * @return the removed handler
 */
-(id<JPPipelineHandler>)removeByName:(NSString*)name;

/**
 * Removes the first JPPipelineHandler in this pipeline.
 *
 * @return the removed handler
 *
 */
-(id<JPPipelineHandler>)removeFirst;

/**
 * Removes the last JPPipelineHandler in this pipeline.
 *
 * @return the removed handler
 *
 */
-(id<JPPipelineHandler>)removeLast;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Replace Handler Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Replace Handler Methods
 */
///@{

/**
 * Replaces the specified JPPipelineHandler with a new handler in
 * this pipeline.
 */
-(void)replaceByHandler:(id<JPPipelineHandler>)oldHandler withName:(NSString*)name andHandler:(id<JPPipelineHandler>)handler;

/**
 * Replaces the JPPipelineHandler of the specified name with a new
 * handler in this pipeline.
 *
 * @return the removed handler
 *
 */
-(id<JPPipelineHandler>)replaceByName:(NSString*)oldName withName:(NSString*)newName andHandler:(id<JPPipelineHandler>)newHandler;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Get Handler Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Get Handler Methods
 */
///@{

/**
 * Returns the first JPPipelineHandler in this pipeline.
 *
 * @return the first handler or <tt>nil</tt> if this pipeline is empty.
 */
-(id<JPPipelineHandler>)first;

/**
 * Returns the last JPPipelineHandler in this pipeline.
 *
 * @return the last handler or <tt>nil</tt> if this pipeline is empty.
 */
-(id<JPPipelineHandler>)last;

/**
 * Returns the JPPipelineHandler with the specified name in this
 * pipeline.
 *
 * @return the handler with the specified name or <tt>nil</tt> if there's no such handler in this pipeline.
 *         
 */
-(id<JPPipelineHandler>)get:(NSString*)name;

/**
 * Set handler as final, so he can't be removed or replaced.
 *
 * @param name     the name of the handler to lock.
 */
-(void)setAsFinal:(NSString*)name;

-(JPDefaultHandlerContext*)getActualUpstreamContext:(JPDefaultHandlerContext*)ctx;
-(JPDefaultHandlerContext*)getActualDownstreamContext:(JPDefaultHandlerContext*)ctx;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Send Events Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Send Events Methods
 */
///@{

/**
 * Sends the specified JPPipelineEvent to the first JPPipelineUpstreamHandler in this pipeline.
 * @param e The JPPipelineEvent to send upstream.
 */
-(void)sendUpstream:(id<JPPipelineEvent>)e;

/**
 * Sends the specified JPPipelineEvent to the last JPPipelineDownstreamHandler in this pipeline.
 * @param e The JPPipelineEvent to send downstream.
 */
-(void)sendDownstream:(id<JPPipelineEvent>)e;

-(void)sendContextUpstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e;
-(void)sendContextDownstream:(JPDefaultHandlerContext*)ctx withEvent:(id<JPPipelineEvent>)e;

///@}
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
#pragma mark -
#pragma mark Listener Methods. 
//// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// //// 
/** @name Listener Methods
 */
///@{

/**
 * Send an JPPipelineException when some exception is raised on a JPPipelineEvent.
 * @param exception the <tt>NSException</tt> raised.
 * @param e The JPPipelineEvent that raise this exception.
 */
-(void)notifyHandlerException:(NSException*)exception withEvent:(id<JPPipelineEvent>)e;

///@}
@end


#pragma mark -
#pragma mark Main Page
/*! \mainpage JUMP Network Programming Guide
 
 <b>JUMP Network Module</b> is an collection of classes that perform I/O network operations.<br>
 <br>
 His core component is based on a implementation of the <a href="http://java.sun.com/blueprints/corej2eepatterns/Patterns/InterceptingFilter.html">Intercepting Filter Pattern</a>
 that is an presentation-tier request handling mechanism to receive many different types of requests, 
 which require varied types of processing. Giving the power to analyze each request and simply forward to
 the appropriate handler component, while other requests must be modified, audited,
 or uncompressed before being further processed.<br>
 <br>
 This module also pack many pre-builded components to handle many types of messages, such as JSON 
 and XML encoders and decoders.<br>
 <br>
 The <b>Pipeline</b> design model was inspired on the excelent <a href="http://www.jboss.org/netty">Netty</a> 
 project from <a href="http://gleamynode.net/">Trustin Lee</a>. If you're familiar with this
 framework use the JUMP Network components will be a breeze. <b>Thanks Trustin</b> by his wonderful code.<br>
 <br>
 This module was designed to be as more flexible as posible. So you can design and/or reuse your 
 components, like an HTTP transporter class or an JSON parser. This module provides this components,
 but you can use your own.
 
  <h2>Learn more about this module in the following sections:</h2>
  - \subpage the_pipeline
  - \subpage handlers_page
  - \subpage events_page
  - \subpage messages_page
  - \subpage transporter_page
  - \subpage factories_page
  
   <h2>Also consult the documentation of this classes for further information</h2>
   - \ref handlers_group 
   - \ref events_group 

 */

// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark The Pipeline
 
 /*! \page the_pipeline The Pipeline
 JPPipeline implements an advanced form of the <a href="http://java.sun.com/blueprints/corej2eepatterns/Patterns/InterceptingFilter.html">Intercepting Filter Pattern</a>
 to give a user full control over how an event is handled and how the JPPipelineHandler in
 the pipeline interact with each other.
 
 <h2>How an event flows in a pipeline</h2>
 
 The following diagram describes how a \link JPPipelineEvent Event\endlink are processed by an
 \link JPPipelineHandler Handler\endlink in a \link JPPipeline Pipeline\endlink.
 <p>
 A JPPipelineEvent can be handled by either a JPPipelineUpstreamHandler
 or a JPPipelineDownstreamHandler and be forwarded to the closest
 handler by calling JPPipelineHandlerContext::sendUpstream: or JPPipelineHandlerContext::sendDownstream:.
 The meaning of the event is interpreted somewhat differently depending on whether it is
 going upstream or going downstream. Please refer to JPPipelineEvent for
 more information.

 \image html JUMPNetworkDiagrams.jpg
 
 An upstream event is handled by the upstream handlers in the bottom-up
 direction as shown on the left side of the diagram.  An upstream handler
 usually handles the inbound data on the bottom of the diagram.
 The inbound data is often read from a remote peer via the
 actual input operation. If an upstream event goes beyond the top upstream handler,
 it is discarded silently.
 <p>
 A downstream event is handled by the downstream handler in the top-down
 direction as shown on the right side of the diagram.  A downstream handler
 usually generates or transforms the outbound traffic such as write requests.
 If a downstream event goes beyond the bottom downstream handler, it is
 handled by an transporter object associated with the JPPipeline. The transporter 
 often performs the actual output operation.
 <p>

 
 For example, let us assume that we created the following pipeline:
 \code
 JPPipeline *p = [[JPPipeline init] retain];
 [p addLast:@"1" withHandler:[UpstreamHandlerA init]];
 [p addLast:@"2" withHandler:[UpstreamHandlerB init]];
 [p addLast:@"3" withHandler:[DownstreamHandlerA init]];
 [p addLast:@"4" withHandler:[DownstreamHandlerB init]];
 [p addLast:@"5" withHandler:[UpstreamHandlerX init]];
 \endcode
 
 
 In the example above, the class whose name starts with <b>Upstream</b> means
 it is an upstream handler.  The class whose name starts with
 <b>Downstream</b> means it is a downstream handler.
 <p>
 
 In the given example configuration, the handler evaluation order is 1, 2, 3,
 4, 5 when an event goes upstream.  When an event goes downstream, the order
 is 5, 4, 3, 2, 1.  On top of this principle, JPPipeline skips
 the evaluation of certain handlers to shorten the stack depth:
 <ul>
 <li>3 and 4 don't implement JPPipelineUpstreamHandler, and therefore the
 actual evaluation order of an upstream event will be: 1, 2, and 5.</li>
 <li>1, 2, and 5 don't implement JPPipelineDownstreamHandler, and
 therefore the actual evaluation order of a downstream event will be:
 4 and 3.</li>
 <li>If 5 extended JPSimplePipelineHandler which implements both
 JPPipelineUpstreamHandler and JPPipelineDownstreamHandler, the
 evaluation order of an upstream and a downstream event could be 1, 2, 5 and
 5, 4, 3 respectively.</li>
 </ul>
 
 <h2>Building a pipeline</h2>
 <p>
 A user is supposed to have one or more JPPipelineHandler in a
 pipeline to receive I/O events (e.g. read) and to request I/O operations
 (e.g. write).  For example, a typical application will have the following
 handlers in each channel's pipeline, but your mileage may vary depending on
 the complexity and characteristics of the protocol and business logic:
 
 <ol>
 <li>Protocol Decoder - translates binary data into a Objective-C object.</li>
 <li>Protocol Encoder - translates a Objective-C object into binary data.</li>
 <li>Business Logic Handler - performs the actual business logic (e.g. database access).</li>
 </ol>
 
 and it could be represented as shown in the following example:
 
 \code
 JPPipeline* pipeline = [[JPPipeline init] retain];
 [p addLast:@"decoder" withHandler:[MyProtocolDecoder init]];
 [p addLast:@"encoder" withHandler:[MyProtocolEncoder init]];
 [p addLast:@"handler" withHandler:[MyBusinessLogicHandler init]];
\endcode
 
 <h2>Thread safety</h2>
 <p>
 A JPPipelineHandler can be added or removed at any time because a
 JPPipeline is thread safe.  For example, you can insert a
 <b>SslHandler</b> when sensitive information is about to be exchanged,
 and remove it after the exchange.
 
 <h2>Pitfall</h2>
 <p>
 Due to the internal implementation detail of the current default
 JPPipeline, the following code does not work as expected if
 <tt>FirstHandler</tt> is the last handler in the pipeline:

 \code
 @interface FirstHandler : JPSimplePipelineUpstreamHandler {}
 @end
 
 @implementation FirstHandler
 
 -(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
	 // Remove this handler from the pipeline,
	 [[ctx getPipeline] removeByHandler:self];
	 // And let SecondHandler handle the current event.
	 [[ctx getPipeline] addLast:@"2nd" withHandler:[SecondHandler init]];
	 [ctx sendUpstream:e];
 }
 @end
 \endcode

 To implement the expected behavior, you have to add <tt>SecondHandler</tt>
 before the removal or make sure there is at least one more handler between
 <tt>FirstHandler</tt> and <tt>SecondHandler</tt>.

 */

// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark I|O Transporter

 /*! \page transporter_page I|O Transporter
  \ref the_pipeline doesn't have an I|O transporter embedded. You must inform an <b>Transporter
  Implementation</b> of the JPPipelineSink protocol that handles the transport between your application
  and another network peer. This transporter could be an HTTP class, a SOCKET class or another
  implementation of network communication.
  <p>
  <h2>The default HTTP Transporter</h2>
  <b>JUMP Network</b> includes an \link JPHTTPTransporter HTTP transporter\endlink implementation that you can use.
  @copydetails JPHTTPTransporter
  @copydetails JPTransporterHTTPEvent
 */
	 
// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark Handlers

 /*! \page handlers_page Handlers
 Well-defined and extensible event model is a must for an event-driven application. 
 JUMP Framework does have a well-defined event model focused on I|O. It also allows
 you to implement your own event type without breaking the existing code at all
 because each event type is distinguished from each other by strict type hierarchy. 
<p>
 A JPPipelineEvent is handled by a list of JPPipelineHandler in a JPPipeline. \ref the_pipeline
 implements an advanced form of the <a href="http://java.sun.com/blueprints/corej2eepatterns/Patterns/InterceptingFilter.html">Intercepting Filter</a>
 pattern to give a user full control over how an event is handled and how the handlers
 in the pipeline interact with each other. For example, you can define what to do when a data
 is readed:
 \code
 @interface MyReadHandler : JPSimplePipelineHandler {}
 @end
 
 @implementation MyReadHandler
 
 -(void)messageReceived:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
	  id message = [e getMessage];
	  // Do something with the received message.
	  ...
	  
	  // And forward the event to the next handler.
	  [ctx sendUpstream:e];
 }
 @end
 \endcode
 You can also define what to do when other handler requested a write operation:
 \code
 @interface MyWriteHandler : JPSimplePipelineHandler {}
 @end
 
 @implementation MyWriteHandler
 
 -(void)writeRequested:(id<JPPipelineHandlerContext>)ctx withMessageEvent:(id<JPPipelineMessageEvent>)e {
	  id message = [e getMessage];
	  // Do something with the message to be written.
	  ...
	  
	  // And forward the event to the next handler.
	  [ctx sendDownstream:e];
 }
 @end
 \endcode
 
 For more information about the event model, please refer to JPPipelineEvent and JPPipeline.
 <p>
 See \ref jsonrpc_messages_page to learn about some custom and more specific handlers.
 <br>
 <br>
 */


// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark Using Factories
 
 /*! \page factories_page Using Factories


 */
 
 
// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark Events

 /*! \page events_page Event
  A JPPipelineEvent is supposed to be handled by the JPPipeline which is attached.
  Once an event is sent to a JPPipeline, it is handled by a list of JPPipelineHandler.
 
  <h2>Upstream events and downstream events, and their interpretation</h2>
  <p>
  Every event is either an upstream event or a downstream event.
  If an event flows forward from the first handler to the last handler in a
  JPPipeline, we call it an upstream event and say <strong>"an
  event goes upstream."</strong>  If an event flows backward from the last
  handler to the first handler in a JPPipeline, we call it a
  downstream event and say <strong>"an event goes downstream."</strong>
  (Please refer to the diagram in \ref the_pipeline  for more explanation.)
  <p>
  When your server receives a \link messages_page message\endlink from a client, the event
  associated with the received \link messages_page message\endlink is an upstream event.
  When your server sends a \link messages_page message\endlink 
  or reply to the client, the event associated with the write request is a
  downstream event.  The same rule applies for the client side.  If your client
  sent a request to the server, it means your client triggered a downstream
  event.  If your client received a response from the server, it means
  your client will be notified with an upstream event.  Upstream events are
  often the result of inbound operations and downstream events are the
  request for outbound operations.
  
  <h2>Cancelling Events</h2>
  @copydetails JPDefaultCancelEvent
 
  <h2>Default Events Messages Types</h2>
  @copydoc messages_page
 
  <h2>Additional resources worth reading</h2>

  Please refer to the documentation of JPPipelineHandler and its sub-types 
  (JPPipelineUpstreamHandler for upstream events and JPPipelineDownstreamHandler
  for downstream events) to find out how a JPPipelineEvent is interpreted depending 
  on the type of the handler more in detail. 
  Also, please refer to the JPPipeline documentation to find out how an event flows in a pipeline.
  And \ref transporter_page to learn about I|O transporter and some default implementations.
 */

// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark Events Message
 
  /*! \page messages_page Event Message
  
  \ref messages_page are some kind of data that is transported by an \ref events_page. \ref messages_page
  doesn't have an defined type on the \ref the_pipeline. The <b>type</b> of the \ref messages_page 
  concern to the \ref handlers_page. They use the <b>Message Type</b> to known if they can handle or not.
  <p>
  Also the \ref handlers_page usually transform the message on his way through the \ref the_pipeline.
  <p>
  <b>JUMP Network</b> come with a bundled collection of \ref messages_page that you can use or 
  reuse in your own subclasses.<br>
  These are the main groups of this messages:
  	- \subpage http_messages_page 
  	- \subpage jsonrpc_messages_page 

  */
	 
// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark HTTP Events Messages
 
  /*! \page http_messages_page HTTP Event Messages
  @copydetails JPDefaultHTTPMessage
  */
  
// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark JSON-RPC Events Messages
 
  /*! \page jsonrpc_messages_page JSON-RPC Event Messages
  @copydetails JPJSONRPCMessage
  
   <h2>JSON-RPC Encoder and Decoder</h2>
   \ref jsonrpc_messages_page are processed by they respectives JSON-RPC \ref handlers_page that
   \link JPJSONRPCDecoderHandler decode\endlink and \link JPJSONRPCEncoderHandler encode\endlink 
   the \ref messages_page upstream or downstream respectively.
   
   <h2>Encoder</h2>
   \copydetails JPJSONRPCEncoderHandler

   <h2>Decoder</h2>
   \copydetails JPJSONRPCDecoderHandler

  */
  
// ///////// //////// //////// //////// //////// //////// //////// //////// //////// //////// ////////  
#pragma mark -
#pragma mark Groups Definitions
  
 
/** @defgroup handlers_group Pipeline Handlers
 *  This is are all Pipeline \ref handlers_page protocols and classes.
 */

/** @defgroup events_group Pipeline Events
 * This is are all Pipeline \ref events_page protocols and classes.
 */

/** @defgroup transporter_group HTTP Transporter Components
 * This is are all HTTP JUMP Network Components. See \ref transporter_page for more information.
 */
 
/** @defgroup jsonrpc_group JSON-RPC Transporter Components
 * This is are all JSON-RPC JUMP Network Components. 
 See \ref jsonrpc_messages_page to learn about \ref events_page that use HTTP components 
 as basis and \ref transporter_page for further information.
 */
 
 
 





