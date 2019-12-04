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

- (NSArray *)arrayByMapping:(id (^)(id object))block
{
	return [self mutableArrayByMapping:block];
}

- (NSMutableArray *)mutableArrayByMapping:(id (^)(id object))block
{
	NSMutableArray *result = [NSMutableArray array];

	for (id object in self)
	{
		id mapping = block(object);
		if ( mapping ) { [result addObject:mapping]; }
	}

	return result;
}


- (NSSet *)setByMapping:(id (^)(id object))block
{
	return [self mutableSetByMapping:block];
}

- (NSMutableSet *)mutableSetByMapping:(id (^)(id object))block
{
	NSMutableSet *resultSet = [NSMutableSet set];

	for (id object in self)
	{
		id mapping = block(object);
		if ( mapping ) { [resultSet addObject:mapping]; }
	}

	return resultSet;
}


- (NSOrderedSet *)orderedSetByMapping:(id (^)(id object))block
{
	return [self mutableOrderedSetByMapping:block];
}

- (NSMutableOrderedSet *)mutableOrderedSetByMapping:(id (^)(id object))block
{
	NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];

	for (id object in self)
	{
		id mapping = block(object);
		if ( mapping ) { [result addObject:mapping]; }
	}

	return result;
}


#pragma mark - Filtering

- (NSArray *)arrayByFiltering:(BOOL (^)(id object))block
{
	return [self mutableArrayByFiltering:block];
}

- (NSMutableArray *)mutableArrayByFiltering:(BOOL (^)(id object))block
{
	NSMutableArray *result = [NSMutableArray array];

	for (id object in self)
	{
		if ( block(object) ) { [result addObject:object]; }
	}

	return result;
}

- (NSSet *)setByFiltering:(BOOL (^)(id object))block
{
	return [self mutableSetByFiltering:block];
}

- (NSMutableSet *)mutableSetByFiltering:(BOOL (^)(id object))block
{
	NSMutableSet *result = [NSMutableSet set];

	for (id object in self)
	{
		if ( block(object) ) { [result addObject:object]; }
	}

	return result;
}

- (NSOrderedSet *)orderedSetByFiltering:(BOOL (^)(id object))block
{
	return [self mutableOrderedSetByFiltering:block];
}

- (NSMutableOrderedSet *)mutableOrderedSetByFiltering:(BOOL (^)(id object))block
{
	NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];

	for (id object in self)
	{
		if ( block(object) ) { [result addObject:object]; }
	}

	return result;
}


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id memo, id object))block
{
	id result = initial;

	for (id object in self)
	{
		result = block(result, object);
	}

	return result;
}

@end
