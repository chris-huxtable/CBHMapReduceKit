//  NSEnumeratorTests.m
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


@interface NSEnumeratorTests : XCTestCase
@end


@implementation NSEnumeratorTests

#pragma mark - Mapping

- (void)testArray_mapping
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSArray<NSString *> *mapping = [enumerator arrayByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSArray<NSString *> *expected = @[@"2", @"6", @"10", @"14", @"18"];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testSet_mapping
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSSet<NSString *> *mapping = [enumerator setByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSSet<NSString *> *expected = [NSSet setWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testOrderedSet_mapping
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSOrderedSet<NSString *> *mapping = [enumerator orderedSetByMapping:^id(NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSOrderedSet<NSString *> *expected = [NSOrderedSet orderedSetWithArray:@[@"2", @"6", @"10", @"14", @"18"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}


#pragma mark - Filtering

- (void)testArray_filtering
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSArray<NSNumber *> *mapping = [enumerator arrayByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSArray<NSNumber *> *expected = @[@2, @4, @6, @8, @10];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testSet_filtering
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSSet<NSNumber *> *mapping = [enumerator setByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSSet<NSNumber *> *expected = [NSSet setWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testOrderedSet_filtering
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSOrderedSet<NSNumber *> *mapping = [enumerator orderedSetByFiltering:^BOOL(NSNumber *object) {
		return ( [object unsignedIntValue] % 2 == 0 );
	}];
	NSOrderedSet<NSNumber *> *expected = [NSOrderedSet orderedSetWithArray:@[@2, @4, @6, @8, @10]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}


#pragma mark - Reducing

- (void)testReduce
{
	NSEnumerator<NSNumber *> *enumerator = [@[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10] objectEnumerator];
	NSNumber *reduction = [enumerator initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
		return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
	}];
	NSNumber *expected = @55;

	XCTAssertEqualObjects(reduction, expected, @"The two numbers should be the same.");
}

@end
