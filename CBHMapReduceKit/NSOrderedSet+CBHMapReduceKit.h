//  NSOrderedSet+CBHMapReduceKit.h
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

@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface NSOrderedSet<ObjectType> (CBHMapReduceKit)

#pragma mark - Mapping

- (NSOrderedSet<id> *)orderedSetByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableOrderedSet<id> *)mutableOrderedSetByMapping:(nullable id (^)(ObjectType object))block;


#pragma mark - Filtering

- (NSOrderedSet<ObjectType> *)orderedSetByFiltering:(BOOL (^)(ObjectType object))block;
- (NSMutableOrderedSet<ObjectType> *)mutableOrderedSetByFiltering:(BOOL (^)(ObjectType object))block;


#pragma mark - Reducing

- (nullable id)initial:(nullable id)initial reduce:(nullable id (^)(id __nullable memo, ObjectType object))reduce;


#pragma mark - Cross-Collection Mappings

- (NSArray<id> *)arrayByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableArray<id> *)mutableArrayByMapping:(nullable id (^)(ObjectType object))block;

- (NSSet<id> *)setByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableSet<id> *)mutableSetByMapping:(nullable id (^)(ObjectType object))block;


#pragma mark - Collection Conversion

- (NSSet<ObjectType> *)toSet;
- (NSMutableSet<ObjectType> *)toMutableSet;

- (NSArray<ObjectType> *)toArray;
- (NSMutableArray<ObjectType> *)toMutableArray;

@end


@interface NSMutableOrderedSet<ObjectType> (CBHMapReduceKit)

#pragma mark - Filtering

- (instancetype)filter:(BOOL (^)(ObjectType object))block;

@end

NS_ASSUME_NONNULL_END
