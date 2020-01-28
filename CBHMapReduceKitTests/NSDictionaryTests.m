//  NSDictionaryTests.m
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


@interface NSDictionaryTests : XCTestCase
@end


@implementation NSDictionaryTests

#pragma mark - Map, Filter, Reduce

- (void)testMapping
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSDictionary<NSString *, NSString *> *mapping = [dictionary dictionaryByMapping:^NSString *(NSString *key, NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSDictionary<NSString *, NSString *> *expected = @{ @"a": @"2", @"c": @"6" };

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testFiltering
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSDictionary<NSString *, NSNumber *> *mapping = [dictionary dictionaryByFiltering:^BOOL(NSString *key, NSNumber *object) {
		return ( [object unsignedIntValue] % 2 != 0 ) ;
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"a": @1, @"c": @3};

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testReduce
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSNumber *reduction = [dictionary initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
		return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
	}];
	NSNumber *expected = @6;

	XCTAssertEqualObjects(reduction, expected, @"The two numbers should be the same.");
}


#pragma mark - Cross Collection

- (void)testArray
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSArray<NSString *> *mapping = [dictionary arrayByMapping:^NSString *(NSString *key, NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSArray<NSString *> *expected = @[@"2", @"6"];

	XCTAssertEqualObjects(mapping, expected, @"The two arrays should be the same.");
}

- (void)testSet
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSSet<NSString *> *mapping = [dictionary setByMapping:^NSString *(NSString *key, NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSSet<NSString *> *expected = [NSSet setWithArray:@[@"2", @"6"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

- (void)testOrderedSet
{
	NSDictionary<NSString *, NSNumber *> *dictionary = @{@"a": @1, @"b": @2, @"c": @3};
	NSOrderedSet<NSString *> *mapping = [dictionary orderedSetByMapping:^NSString *(NSString *key, NSNumber *object) {
		NSUInteger value = [object unsignedIntValue];
		if ( value % 2 == 0 ) { return nil; }
		return [NSString stringWithFormat:@"%lu", value + value];
	}];
	NSOrderedSet<NSString *> *expected = [NSOrderedSet orderedSetWithArray:@[@"2", @"6"]];

	XCTAssertEqualObjects(mapping, expected, @"The two sets should be the same.");
}

@end


@interface NSMutableDictionaryTests : XCTestCase
@end


@implementation NSMutableDictionaryTests

- (void)testMapping
{
	NSMutableDictionary<NSString *, NSNumber *> *mapping = [@{@"a": @1, @"b": @2, @"c": @3} mutableCopy];
	[mapping map:^NSNumber * _Nonnull(NSString *key, NSNumber *value) {
		NSInteger intValue = [value integerValue];
		if ( intValue % 2 == 0 ) { return @(intValue + intValue); }
		return value;
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"a": @1, @"b": @4, @"c": @3};

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testCompactMapping
{
	NSMutableDictionary<NSString *, NSNumber *> *mapping = [@{@"a": @1, @"b": @2, @"c": @3} mutableCopy];
	[mapping compactMap:^NSNumber *(NSString *key, NSNumber *value) {
		NSInteger intValue = [value integerValue];
		if ( intValue % 2 == 0 ) { return @(intValue + intValue); }
		if ( intValue % 3 == 0 ) { return value; }
		return nil;
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"b": @4, @"c": @3};

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testRekeying
{
	NSMutableDictionary<NSString *, NSNumber *> *mapping = [@{@"a": @1, @"b": @2, @"c": @3} mutableCopy];
	[mapping rekey:^NSString * _Nonnull(NSString *key, NSNumber *value) {
		NSInteger intValue = [value integerValue];
		if ( intValue % 2 == 0 ) { return [key capitalizedString]; }
		return key;
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"a": @1, @"B": @2, @"c": @3};

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testCompactRekeying
{
	NSMutableDictionary<NSString *, NSNumber *> *mapping = [@{@"a": @1, @"b": @2, @"c": @3} mutableCopy];
	[mapping compactRekey:^NSString *(NSString *key, NSNumber *value) {
		NSInteger intValue = [value integerValue];
		if ( intValue % 2 == 0 ) { return [key capitalizedString]; }
		if ( intValue % 3 == 0 ) { return key; }
		return nil;
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"B": @2, @"c": @3};

	XCTAssertEqualObjects(mapping, expected, @"The two dictionaries should be the same.");
}

- (void)testFiltering
{
	NSMutableDictionary<NSString *, NSNumber *> *dictionary = [@{@"a": @1, @"b": @2, @"c": @3} mutableCopy];
	[dictionary filter:^BOOL(NSString *key, NSNumber *object) {
		return ( [object unsignedIntValue] % 2 != 0 );
	}];
	NSDictionary<NSString *, NSNumber *> *expected = @{@"a": @1, @"c": @3};

	XCTAssertEqualObjects(dictionary, expected, @"The two dictionaries should be the same.");
}

@end
