//  NSSetTests.m
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


@interface NSSetTests : XCTestCase
@end


@implementation NSSetTests

#pragma mark - Map, Filter, Reduce

- (void)testMapping
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSSet<NSString *> *mapping = [set setByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSSet<NSString *> *expected = [NSSet setWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}


- (void)testFiltering
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSSet<NSNumber *> *mapping = [set setByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSSet<NSNumber *> *expected = [NSSet setWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testReduce
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSNumber *reduction = [set initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
		return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
	}];
	NSNumber *expected = @55;

	XCTAssertEqualObjects(reduction, expected, @"The two numbers should be the same.");
}


#pragma mark - Cross Collection

- (void)testArray
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
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

- (void)testOrderedSet
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSOrderedSet<NSString *> *mapping = [set orderedSetByMapping:^NSString *(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSOrderedSet<NSString *> *expected = [NSOrderedSet orderedSetWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	/// Make order consistent.
	NSArray<NSString *> *mappingArray = [[mapping array] sortedArrayUsingSelector:@selector(compare:)];
	NSArray<NSString *> *expectedArray = [[expected array] sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mappingArray, expectedArray, @"The two arrays should be the same.");
}


#pragma mark - To Other Collection

- (void)testToArray
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSArray<NSNumber *> *mapping = [set toArray];
	NSArray<NSNumber *> *expected = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];

	/// Make order consistent.
	mapping = [mapping sortedArrayUsingSelector:@selector(compare:)];
	expected = [expected sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testToOrderedSet
{
	NSSet<NSNumber *> *set = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	NSOrderedSet<NSNumber *> *mapping = [set toOrderedSet];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];

	/// Make order consistent.
	NSArray<NSNumber *> *mappingArray = [[mapping array] sortedArrayUsingSelector:@selector(compare:)];
	NSArray<NSNumber *> *expectedArray = [[expected array] sortedArrayUsingSelector:@selector(compare:)];

	XCTAssertEqualObjects(mappingArray, expectedArray, @"The two arrays should be the same.");
}

@end


@interface NSMutableSetTests : XCTestCase
@end


@implementation NSMutableSetTests

- (void)testFiltering
{
	NSMutableSet<NSNumber *> *mapping = [NSMutableSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];
	[mapping filter:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSSet<NSNumber *> *expected = [NSSet setWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

@end
