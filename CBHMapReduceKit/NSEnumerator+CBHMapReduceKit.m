//  NSEnumerator+CBHMapReduceKit.m
//  CBHMapReduceKit
//
//  Created by Christian Huxtable <chris@huxtable.ca>, November 2019.
//  Copyright (c) 2019 Christian Huxtable. All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
//  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#import "NSEnumerator+CBHMapReduceKit.h"


@implementation NSEnumerator (CBHMapReduceKit)

#pragma mark - Mapping

- (NSArray *)arrayByMapping:(id (^)(id object))transform
{
	return [self mutableArrayByMapping:transform];
}

- (NSMutableArray *)mutableArrayByMapping:(id (^)(id object))transform
{
	NSMutableArray *result = [NSMutableArray array];

	for (id object in self)
	{
		id mapping = transform(object);
		if ( mapping ) { [result addObject:mapping]; }
	}

	return result;
}


- (NSSet *)setByMapping:(id (^)(id object))transform
{
	return [self mutableSetByMapping:transform];
}

- (NSMutableSet *)mutableSetByMapping:(id (^)(id object))transform
{
	NSMutableSet *resultSet = [NSMutableSet set];

	for (id object in self)
	{
		id mapping = transform(object);
		if ( mapping ) { [resultSet addObject:mapping]; }
	}

	return resultSet;
}


- (NSOrderedSet *)orderedSetByMapping:(id (^)(id object))transform
{
	return [self mutableOrderedSetByMapping:transform];
}

- (NSMutableOrderedSet *)mutableOrderedSetByMapping:(id (^)(id object))transform
{
	NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];

	for (id object in self)
	{
		id mapping = transform(object);
		if ( mapping ) { [result addObject:mapping]; }
	}

	return result;
}


#pragma mark - Filtering

- (NSArray *)arrayByFiltering:(BOOL (^)(id object))predicate
{
	return [self mutableArrayByFiltering:predicate];
}

- (NSMutableArray *)mutableArrayByFiltering:(BOOL (^)(id object))predicate
{
	NSMutableArray *result = [NSMutableArray array];

	for (id object in self)
	{
		if ( predicate(object) ) { [result addObject:object]; }
	}

	return result;
}

- (NSSet *)setByFiltering:(BOOL (^)(id object))predicate
{
	return [self mutableSetByFiltering:predicate];
}

- (NSMutableSet *)mutableSetByFiltering:(BOOL (^)(id object))predicate
{
	NSMutableSet *result = [NSMutableSet set];

	for (id object in self)
	{
		if ( predicate(object) ) { [result addObject:object]; }
	}

	return result;
}

- (NSOrderedSet *)orderedSetByFiltering:(BOOL (^)(id object))predicate
{
	return [self mutableOrderedSetByFiltering:predicate];
}

- (NSMutableOrderedSet *)mutableOrderedSetByFiltering:(BOOL (^)(id object))predicate
{
	NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];

	for (id object in self)
	{
		if ( predicate(object) ) { [result addObject:object]; }
	}

	return result;
}


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id accumulated, id object))reduce
{
	id accumulated = initial;

	for (id object in self)
	{
		accumulated = reduce(accumulated, object);
	}

	return accumulated;
}

@end
