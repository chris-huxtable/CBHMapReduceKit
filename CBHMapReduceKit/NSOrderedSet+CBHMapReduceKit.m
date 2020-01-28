//  NSOrderedSet+CBHMapReduceKit.m
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

#import "NSOrderedSet+CBHMapReduceKit.h"


@implementation NSOrderedSet (CBHMapReduceKit)

#pragma mark - Mapping

- (NSOrderedSet *)orderedSetByMapping:(id (^)(id object))block
{
	return [self mutableOrderedSetByMapping:block];
}

- (NSMutableOrderedSet *)mutableOrderedSetByMapping:(id (^)(id object))block
{
	NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] initWithCapacity:[self count]];

	for (id object in self)
	{
		id mapping = block(object);
		if ( mapping ) { [result addObject:mapping]; }
	}

	return result;
}


- (NSArray *)arrayByMapping:(id (^)(id object))block
{
	return [self mutableArrayByMapping:block];
}

- (NSMutableArray *)mutableArrayByMapping:(id (^)(id object))block
{
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count]];

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
	NSMutableSet *resultSet = [[NSMutableSet alloc] initWithCapacity:[self count]];

	for (id object in self)
	{
		id mapping = block(object);
		if ( mapping ) { [resultSet addObject:mapping]; }
	}

	return resultSet;
}


#pragma mark - Filtering

- (NSOrderedSet *)orderedSetByFiltering:(BOOL (^)(id object))predicate
{
	return [self mutableOrderedSetByFiltering:predicate];
}

- (NSMutableOrderedSet *)mutableOrderedSetByFiltering:(BOOL (^)(id object))predicate
{
	NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] initWithCapacity:[self count]];

	for (id object in self)
	{
		if ( predicate(object) ) { [result addObject:object]; }
	}

	return result;
}


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id memo, id object))reduce
{
	id result = initial;

	for (id object in self)
	{
		result = reduce(result, object);
	}

	return result;
}


#pragma mark - Collection Conversion

- (NSArray *)toArray
{
	return [self toMutableArray];
}

- (NSMutableArray *)toMutableArray
{
	return [self mutableArrayByMapping:^id(id object) { return object; }];
}


- (NSSet *)toSet
{
	return [self toMutableSet];
}

- (NSMutableSet *)toMutableSet
{
	return [self mutableSetByMapping:^id(id object) { return object; }];
}

@end


@implementation NSMutableOrderedSet (CBHMapReduceKit)

#pragma mark - Filtering

- (instancetype)filter:(BOOL (^)(id object))predicate
{
	NSMutableIndexSet *removals = [NSMutableIndexSet indexSet];

	[self enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
		if ( !predicate(object) ) { [removals addIndex:idx]; }
	}];

	[self removeObjectsAtIndexes:removals];
	return self;
}

@end
