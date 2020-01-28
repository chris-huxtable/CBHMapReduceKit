//  NSOrderedSetTests.m
//  CBHMapReduceKitTests
//
//  Created by Christian Huxtable <chris@huxtable.ca>, December 2019.
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

@import XCTest;
@import CBHMapReduceKit;


@interface NSOrderedSetTests : XCTestCase
@end


@implementation NSOrderedSetTests

#pragma mark - Map, Filter, Reduce

- (void)testMapping
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSOrderedSet<NSString *> *mapping = [set orderedSetByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSOrderedSet<NSString *> *expected = [NSOrderedSet orderedSetWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testFiltering
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSOrderedSet<NSNumber *> *mapping = [set orderedSetByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testReduce
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSNumber *reduction = [set initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
		return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
	}];
	NSNumber *expected = @55;

	XCTAssertEqualObjects(reduction, expected, @"The two numbers should be the same.");
}


#pragma mark - Cross Collection

- (void)testArray
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSArray<NSString *> *mapping = [set arrayByMapping:^NSString *(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSArray<NSString *> *expected = @[@"2", @"6", @"10", @"14", @"18"];

	/// Make order consistent.
	mapping = [mapping sortedArrayUsingSelector:@selector(compare:)];
	expected = [expected sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testSet
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSSet<NSString *> *mapping = [set setByMapping:^NSString *(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSSet<NSString *> *expected = [NSSet setWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	/// Make order consistent.
	NSArray<NSString *> *mappingArray = [[mapping allObjects] sortedArrayUsingSelector:@selector(compare:)];
	NSArray<NSString *> *expectedArray = [[expected allObjects] sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mappingArray, expectedArray, @"The two arrays should be the same.");
}


#pragma mark - To Other Collection

- (void)testToArray
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSArray<NSNumber *> *mapping = [set toArray];
	NSArray<NSNumber *> *expected = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];

	/// Make order consistent.
	mapping = [mapping sortedArrayUsingSelector:@selector(compare:)];
	expected = [expected sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testToSet
{
	NSOrderedSet<NSNumber *> *set = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSSet<NSNumber *> *mapping = [set toSet];
	NSSet<NSNumber *> *expected = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];

	/// Make order consistent.
	NSArray<NSNumber *> *mappingArray = [[mapping allObjects] sortedArrayUsingSelector:@selector(compare:)];
	NSArray<NSNumber *> *expectedArray = [[expected allObjects] sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mappingArray, expectedArray, @"The two sets should be the same.");
}

@end


@interface NSMutableOrderedSetTests : XCTestCase
@end


@implementation NSMutableOrderedSetTests

- (void)testMapping
{
	NSMutableOrderedSet<NSNumber *> *mapping = [NSMutableOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	[mapping map:^id(NSNumber *object) {
		NSInteger value = [object integerValue];
		if ( value % 2 == 0 ) { return @(value + value); }
		return object;
	}];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @12, @7, @16, @9, @20]];

	XCTAssertEqualObjects(mapping, expected, @"The two ordered sets should be the same.");
}

- (void)testCompactMapping
{
	NSMutableOrderedSet<NSNumber *> *mapping = [NSMutableOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	[mapping compactMap:^id(NSNumber *object) {
		NSInteger value = [object integerValue];
		if ( value % 2 == 0 ) { return @(value + value); }
		if ( value % 3 == 0 ) { return object; }
		return nil;
	}];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@2, @3, @4, @12, @16, @9, @20]];

	XCTAssertEqualObjects(mapping, expected, @"The two ordered sets should be the same.");
}

- (void)testFiltering
{
	NSMutableOrderedSet<NSNumber *> *mapping = [NSMutableOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	[mapping filter:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two ordered sets should be the same.");
}

@end
