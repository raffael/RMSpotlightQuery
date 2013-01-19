//
//  RMSpotlightQuery.h
//
//  Created by Raffael Hannemann on 16.01.13.
//  Copyright (c) 2013 raffael.me. All rights reserved.
//

// Under BSD License

/**
 * Objects of this class are NSThread subclasses to query the mdfind command line tool,
 * a tool to query the Spotlight index.
 */

#import <Foundation/Foundation.h>

@class RMSpotlightQuery;

/** The delegate will be notified once the results are available
 */
@protocol RMSpotlightQueryDelegate <NSObject>
/** The delegate method will be called with the sender and the results
 @param query The sender object.
 @param results The array containing the results coming from the Spotlight mdfind tool. Returns nil if empty.
 */
- (void) spotlightQuery: (RMSpotlightQuery *) query didFinishWithResult: (NSArray *) results;
@end

/** Objects of this class are NSThread subclasses to query the mdfind command line tool, a tool to query the Spotlight index.*/
@interface RMSpotlightQuery : NSThread

/** Convenience methods to quickly generate instances. */
+ (instancetype) query;

/** Convenience methods to quickly generate instances.
 @param delegate The delegate to notify once the query results are available.
 */
+ (instancetype) queryWithDelegate: (id<RMSpotlightQueryDelegate>) delegate;

/** Runs a simple query using a needle to search for.
 @param needle The needle to query the Spotlight server with.
 */
- (void) query: (NSString *) needle;

/** Runs a simple query to find an exactly named file by appending the appropriate options to the current set of options.
 @param filename The exact filename to look for.
 */
- (void) queryExactFilename: (NSString *) filename;

/** Runs a query with a set of user-specified options, see the mdfind docs for details. Previously defined options will be prepended.
 @param needle The main argument for the query.
 @param options The set of options to specify the query.
 */
- (void) query: (NSString *) needle withOptions: (NSArray *) options;

/** The needle is the string to search for. */
@property (retain,readonly) NSString *needle;

/** The options array is a set of options. See the mdfind docs for more information. */
@property (retain) NSArray *options;

/** A Tag string that can be set to identify the query, if not identified by reference. */
@property (retain) NSString *tag;

/** The delegate will be notified once the query results are available. */
@property (retain) id<RMSpotlightQueryDelegate> delegate;

@end
