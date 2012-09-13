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

@protocol JPPipelineEvent;
@protocol JPPipelineFutureListener;

/**
 * JPPipelineFuture contains information about the progress and state of determined
 * event navigating trough the Pipeline. You can ask this object directly about
 * different states and also you can attach one object to receive nofitications
 * about his different states.
 */
@protocol JPPipelineFuture	

/**
 * @ingroup events_group
 *
 * Returns YES if and only if this future is
 * complete, regardless of whether the operation was successful, failed,
 * or cancelled.
 */
-(BOOL)isDone;

/**
 * Returns YES if and only if this future was
 * cancelled by a cancel method.
 */
-(BOOL)isCancelled;

/**
 * Returns YES if and only if the operation was completed
 * successfully.
 */
-(BOOL)isSuccess;

/**
 * Returns YES if is started.
 */
-(BOOL)isStarted;

/**
 * Returns YES if is failed.
 */
-(BOOL)isFailed;

/**
 * Current operation overall progress.
 */
-(NSNumber*)getProgress;

/**
 * Set this future current progress.
 */
-(void)setProgress:(NSNumber*)anValue;

/**
 * Returns the cause of the failed I/O operation if the I/O operation has
 * failed.
 *
 * @return the cause of the failure.
 *         NIL if succeeded or this future is not
 *         completed yet.
 */
-(NSError*)getCause;

/**
 * Cancels the I/O operation associated with this future
 * and notifies all listeners if canceled successfully.
 */
-(void)cancel;

/**
 * Marks this future as a success and notifies all
 * listeners.
 */
-(void)setSuccess;

/**
 * Marks this future as a success and attach the
 * event succesfull finish.
 */
-(void)setSuccessWithEvent:(id<JPPipelineEvent>)anEvent;

/**
 * Marks this future as started.
 */
-(void)setStarted;

/**
 * Marks this future as a failure and notifies all
 * listeners.
 */
-(void)setFailure:(NSError*)cause;

/**
 * Adds the specified listener to this future.  The
 * specified listener is notified when this future is
 * done.  If this future is already
 * completed, the specified listener is notified immediately.
 */
-(void)addListener:(id<JPPipelineFutureListener>)anListener;

/**
 * Removes the specified listener from this future.
 * The specified listener is no longer notified when this
 * future is is done.  If the specified
 * listener is not associated with this future, this method
 * does nothing and returns silently.
 */
-(void)removeListener:(id<JPPipelineFutureListener>)anListener;


@end
