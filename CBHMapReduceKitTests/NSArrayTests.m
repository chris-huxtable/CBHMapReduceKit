//  NSArrayTests.m
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


@interface NSArrayTests : XCTestCase
@end


@implementation NSArrayTests

#pragma mark - Map, Filter, Reduce

- (void)testMapping
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSArray<NSString *> *mapping = [array arrayByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSArray<NSString *> *expected = @[@"2", @"6", @"10", @"14", @"18"];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testFiltering
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSArray<NSNumber *> *mapping = [array arrayByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSArray<NSNumber *> *expected = @[@2, @4, @6, @8, @10];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testReduce
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSNumber *reduction = [array initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
		return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
	}];
	NSNumber *expected = @55;

	XCTAssertEqualObjects(reduction, expected, @"The two numbers should be the same.");
}


#pragma mark - Cross Collection

- (void)testSet
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSSet<NSString *> *mapping = [array setByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSSet<NSString *> *expected = [NSSet setWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testOrderedSet
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSOrderedSet<NSString *> *mapping = [array orderedSetByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSOrderedSet<NSString *> *expected = [NSOrderedSet orderedSetWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}


#pragma mark - To Other Collection

- (void)testToSet
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSSet<NSNumber *> *mapping = [array toSet];
	NSSet<NSNumber *> *expected = [NSSet setWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testToOrderedSet
{
	NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
	NSOrderedSet<NSNumber *> *mapping = [array toOrderedSet];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

@end


@interface NSMutableArrayTests : XCTestCase
@end


@implementation NSMutableArrayTests

- (void)testMapping
{
	NSMutableArray<NSNumber *> *mapping = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] mutableCopy];
	[mapping map:^id(NSNumber *object) {
		NSInteger value = [object integerValue];
		if ( value % 2 == 0 ) { return @(value + value); }
		return object;
	}];
	NSArray<NSNumber *> *expected = @[@1, @4, @3, @8, @5, @12, @7, @16, @9, @20];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testCompactMapping
{
	NSMutableArray<NSNumber *> *mapping = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] mutableCopy];
	[mapping compactMap:^id(NSNumber *object) {
		NSInteger value = [object integerValue];
		if ( value % 2 == 0 ) { return @(value + value); }
		if ( value % 3 == 0 ) { return object; }
		return nil;
	}];
	NSArray<NSNumber *> *expected = @[@4, @3, @8, @12, @16, @9, @20];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testFiltering
{
	NSMutableArray<NSNumber *> *mapping = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] mutableCopy];
	[mapping filter:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSArray<NSNumber *> *expected = @[@2, @4, @6, @8, @10];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

@end
