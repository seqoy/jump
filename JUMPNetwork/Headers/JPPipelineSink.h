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
#import "JPPipelineException.h"
@class JPPipeline;


/**
 * Receives and processes the terminal downstream Event.
 * A JPPipelineSink is an internal component which is supposed to be implemented by a transport provider.
 * See \ref transporter_page for more informations.
 */
@protocol JPPipelineSink
@required

/**
 * Invoked by JPPipeline when a downstream JPPipelineEvent has reached its terminal (the head of the pipeline).
 * @param pipeline The pipeline that send the event.
 * @param e The event.
 */
-(void)eventSunk:(JPPipeline*)pipeline withEvent:(id<JPPipelineEvent>)e;

/**
 * Invoked by JPPipeline when an exception was raised while one of its Handlers process a Event.
 * @param anException An JPPipelineException that contains the exception information.
 * @param pipeline The pipeline that send the event.
 * @param e The event.
 */
-(void)exceptionCaught:(JPPipelineException*)anException withPipeline:(JPPipeline*)pipeline withEvent:(id<JPPipelineEvent>)e;

/**
 * The current progress of the transporter provider task.
 * This property should contain values from 0 to 100.
 */
-(NSNumber*)currentProgress;

/**
 * The current progress of the transporter provider task.
 * This property should contain values from 0 to 100.
 */
-(void)setCurrentProgress:(NSNumber*)anValue;

@end