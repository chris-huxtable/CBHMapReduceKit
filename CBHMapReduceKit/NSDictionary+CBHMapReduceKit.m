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

- (NSDictionary *)dictionaryByMapping:(id (^)(id key, id object))transform
{
	return [self mutableDictionaryByMapping:transform];
}

- (NSMutableDictionary *)mutableDictionaryByMapping:(id (^)(id key, id object))transform
{
	NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( mapping ) { [result setObject:mapping forKey:key]; }
	}];

	return result;
}


- (NSArray *)arrayByMapping:(id (^)(id key, id object))transform
{
	return [self mutableArrayByMapping:transform];
}

- (NSMutableArray *)mutableArrayByMapping:(id (^)(id key, id object))transform
{
	NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


- (NSSet *)setByMapping:(id (^)(id key, id object))transform
{
	return [self mutableSetByMapping:transform];
}

- (NSMutableSet *)mutableSetByMapping:(id (^)(id key, id object))transform
{
	NSMutableSet *result = [[NSMutableSet alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


- (NSOrderedSet *)orderedSetByMapping:(id (^)(id key, id object))transform
{
	return [self mutableOrderedSetByMapping:transform];
}

- (NSMutableOrderedSet *)mutableOrderedSetByMapping:(id (^)(id key, id object))transform
{
	NSMutableOrderedSet *result = [[NSMutableOrderedSet alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( mapping ) { [result addObject:mapping]; }
	}];

	return result;
}


#pragma mark - Filtering

- (NSDictionary *)dictionaryByFiltering:(BOOL (^)(id key, id object))predicate
{
	return [self mutableDictionaryByFiltering:predicate];
}

- (NSMutableDictionary *)mutableDictionaryByFiltering:(BOOL (^)(id key, id object))predicate
{
	NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		if ( predicate(key, value) ) { [result setObject:value forKey:key]; }
	}];

	return result;
}


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id accumulated, id object))reduce
{
	id accumulated = initial;

	for (id object in [self objectEnumerator])
	{
		accumulated = reduce(accumulated, object);
	}

	return accumulated;
}

@end


@implementation NSMutableDictionary (CBHMapReduceKit)

#pragma mark - Mapping

- (instancetype)map:(nonnull id (^)(id key, id value))transform
{
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( value == mapping ) { return; }

		[self setObject:mapping forKey:key];
	}];

	return self;
}

- (instancetype)compactMap:(nullable id (^)(id key, id value))transform
{
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( value == mapping ) { return; }
		if ( mapping == nil ) { [self removeObjectForKey:key]; return; }

		[self setObject:mapping forKey:key];
	}];

	return self;
}

- (instancetype)rekey:(nonnull id (^)(id key, id value))transform
{
	NSMutableDictionary *additions = [NSMutableDictionary dictionaryWithCapacity:[self count]];
	NSMutableArray *removals = [NSMutableArray arrayWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( key == mapping ) { return; }

		[removals addObject:key];
		[additions setObject:value forKey:mapping];
	}];

	[self removeObjectsForKeys:removals];
	[self addEntriesFromDictionary:additions];

	return self;
}

- (instancetype)compactRekey:(nullable id (^)(id key, id value))transform
{
	NSMutableDictionary *additions = [NSMutableDictionary dictionaryWithCapacity:[self count]];
	NSMutableArray *removals = [NSMutableArray arrayWithCapacity:[self count]];

	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		id mapping = transform(key, value);
		if ( key == mapping ) { return; }
		[removals addObject:key];

		if ( mapping == nil ) { return; }
		[additions setObject:value forKey:mapping];
	}];

	[self removeObjectsForKeys:removals];
	[self addEntriesFromDictionary:additions];

	return self;
}


#pragma mark - Filtering

- (instancetype)filter:(BOOL (^)(id key, id value))predicate
{
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
		if ( !predicate(key, value) ) { [self removeObjectForKey:key]; }
	}];

	return self;
}

@end
