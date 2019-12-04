//  NSDictionary+CBHMapReduceKit.h
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

@interface NSDictionary<KeyType, ValueType> (CBHMapReduceKit)

#pragma mark - Mapping

- (NSDictionary<KeyType, id> *)dictionaryByMapping:(id (^)(KeyType key, ValueType value))block;
- (NSMutableDictionary<KeyType, id> *)mutableDictionaryByMapping:(id (^)(KeyType key, ValueType value))block;

- (NSArray<id> *)arrayByMapping:(nullable id (^)(KeyType key, ValueType value))block;
- (NSMutableArray<id> *)mutableArrayByMapping:(nullable id (^)(KeyType key, ValueType value))block;

- (NSSet<id> *)setByMapping:(nullable id (^)(KeyType key, ValueType value))block;
- (NSMutableSet<id> *)mutableSetByMapping:(nullable id (^)(KeyType key, ValueType value))block;

- (NSOrderedSet<id> *)orderedSetByMapping:(nullable id (^)(KeyType key, ValueType value))block;
- (NSMutableOrderedSet<id> *)mutableOrderedSetByMapping:(nullable id (^)(KeyType key, ValueType value))block;


#pragma mark - Filtering

- (NSDictionary<KeyType, ValueType> *)dictionaryByFiltering:(BOOL (^)(KeyType key, ValueType value))block;
- (NSMutableDictionary<KeyType, ValueType> *)mutableDictionaryByFiltering:(BOOL (^)(KeyType key, ValueType value))block;


#pragma mark - Reducing

- (id)initial:(id)initial reduce:(id (^)(id memo, ValueType object))block;

@end


@interface NSMutableDictionary<KeyType, ValueType> (CBHMapReduceKit)

#pragma mark - Filtering

- (instancetype)filter:(BOOL (^)(KeyType key, ValueType value))block;

@end

NS_ASSUME_NONNULL_END
