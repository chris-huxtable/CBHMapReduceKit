//  NSDictionary+CBHMapReduceKit.m
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

#import "NSDictionary+CBHMapReduceKit.h"


@implementation NSDictionary (CBHMapReduceKit)


#pragma mark - Mapping

- (NSDictionary *)dictionaryByMapping:(id (^)(id key, id object))block
{
	return [self mutableDictionaryByMapping:block];
}

- (NSMutableDictionary *)mutableDictionaryByMapping:(id (^)(id key, id object))block
{
	NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = block(key, value);
		if ( mapping ) { [result setObject:mapping forKey:key]; }
	}];

	return result;
}


- (NSArray *)arrayByMapping:(id (^)(id key, id object))block
{
	return [self mutableArrayByMapping:block];
}

- (NSMutableArray *)mutableArrayByMapping:(id (^)(id key, id object))block
{
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = block(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


- (NSSet *)setByMapping:(id (^)(id key, id object))block
{
	return [self mutableSetByMapping:block];
}

- (NSMutableSet *)mutableSetByMapping:(id (^)(id key, id object))block
{
	NSMutableSet *result = [[NSMutableSet alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = block(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


- (NSOrderedSet *)orderedSetByMapping:(id (^)(id key, id object))block
{
	return [self mutableOrderedSetByMapping:block];
}

- (NSMutableOrderedSet *)mutableOrderedSetByMapping:(id (^)(id key, id object))block
{
	NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = block(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


#pragma mark - Filtering

- (NSDictionary *)dictionaryByFiltering:(BOOL (^)(id key, id object))block
{
	return [self mutableDictionaryByFiltering:block];
}

- (NSMutableDictionary *)mutableDictionaryByFiltering:(BOOL (^)(id key, id object))block
{
	NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		if ( block(key, value) ) { [result setObject:value forKey:key]; }
	}];

	return result;
}


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id memo, id object))block
{
	id result = initial;

	for (id object in [self objectEnumerator])
	{
		result = block(result, object);
	}

	return result;
}

@end


@implementation NSMutableDictionary (CBHMapReduceKit)

#pragma mark - Filtering

- (instancetype)filter:(BOOL (^)(id key, id value))block
{
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		if ( !block(key, value) ) { [self removeObjectForKey:key]; }
	}];

	return self;
}

@end
