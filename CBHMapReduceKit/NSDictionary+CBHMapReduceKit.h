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

@interface NSDictionary<KeyType, ElementType> (CBHMapReduceKit)

#pragma mark - Mapping

/** Returns a new dictionary containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new dictionary of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSDictionary<KeyType, id> *)dictionaryByMapping:(nullable id (^)(KeyType key, ElementType value))transform;

/** Returns a new mutable dictionary containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new mutable dictionary of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSMutableDictionary<KeyType, id> *)mutableDictionaryByMapping:(nullable id (^)(KeyType key, ElementType value))transform;


/** Returns a new array containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new array of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSArray<id> *)arrayByMapping:(nullable id (^)(KeyType key, ElementType value))transform;

/** Returns a new mutable array containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new mutable array of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSMutableArray<id> *)mutableArrayByMapping:(nullable id (^)(KeyType key, ElementType value))transform;


/** Returns a new set containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new set of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSSet<id> *)setByMapping:(nullable id (^)(KeyType key, ElementType value))transform;

/** Returns a new mutable set containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new mutable set of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSMutableSet<id> *)mutableSetByMapping:(nullable id (^)(KeyType key, ElementType value))transform;


/** Returns a new ordered set containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new ordered set of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSOrderedSet<id> *)orderedSetByMapping:(nullable id (^)(KeyType key, ElementType value))transform;

/** Returns a new mutable ordered set containing the non-`nil` results of calling the given transformation with each element of this dictionary.
 *
 * @param transform     A closure that accepts a key-value pair as its parameters and returns a transformed value of the same or different type.
 *
 * @return              A new mutable ordered set of the non-`nil` results of calling `transform` with each key-value pair of the dictionary.
 */
- (NSMutableOrderedSet<id> *)mutableOrderedSetByMapping:(nullable id (^)(KeyType key, ElementType value))transform;


#pragma mark - Filtering

/** Returns a new dictionary containing the elements of the receiver that satisfy the given predicate.
 *
 * @param predicate     A closure that takes a key-value pair as its arguments and returns a Boolean value indicating whether the element should be included in the returned dictionary.
 *
 * @return              A new dictionary of the key-value pairs that `predicate` allows.
 */
- (NSDictionary<KeyType, ElementType> *)dictionaryByFiltering:(BOOL (^)(KeyType key, ElementType value))predicate;

/** Returns a new mutable dictionary containing the elements of the receiver that satisfy the given predicate.
 *
 * @param predicate     A closure that takes a key value pair as its arguments and returns a Boolean value indicating whether the element should be included in the returned mutable dictionary.
 *
 * @return              A new mutable dictionary of the key-value pairs that `predicate` allows.
 */
- (NSMutableDictionary<KeyType, ElementType> *)mutableDictionaryByFiltering:(BOOL (^)(KeyType key, ElementType value))predicate;


#pragma mark - Reducing

/** Returns the result of combining the elements of the sequence using the given closure.
 *
 * @param initial   The value to use as the initial accumulating value.
 * @param reduce    A closure that returns a new accumulating value resultant from the combination of whats already been accumulated with an element of the sequence.
 *
 * @return          The final accumulated value. If the sequence has no elements, the result is `initial`.
 */
- (id)initial:(id)initial reduce:(id (^)(id accumulated, ElementType object))reduce;

@end


@interface NSMutableDictionary<KeyType, ElementType> (CBHMapReduceKit)

#pragma mark - Mapping

/** Maps the receivers values so that it contains the results of a given closure over each of it's values.
 *
 * @param transform     A closure that accepts a key-value pair of the receiver as its parameters and returns a transformed value of the same type.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the value type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)map:(ElementType (^)(KeyType key, ElementType value))transform;

/** Maps the receiver so that it contains the non-`nil` results of a given closure over each of it's values.
 *
 * @param transform     A closure that accepts a key-value pair of the receiver as its parameters and returns a transformed value of the same type.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the element type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)compactMap:(nullable ElementType (^)(KeyType key, ElementType value))transform;

/** Maps the receivers keys so that it contains the results of a given closure over each of it's values.
 *
 * @param transform     A closure that accepts a key-value pair of the receiver as its parameters and returns a transformed key of the same type.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the key type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)rekey:(KeyType (^)(KeyType key, ElementType value))transform;

/** Maps the receivers keys so that it contains the non-`nil` results of a given closure over each of it's values.
 *
 * @param transform     A closure that accepts a key-value pair of the receiver as its parameters and returns a transformed key of the same type.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the key type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)compactRekey:(nullable KeyType (^)(KeyType key, ElementType value))transform;


#pragma mark - Filtering

/** Filters the receiving dictionary so that it contains only the values that satisfy the given predicate.
 *
 * @param predicate     A closure that takes a key-value pair as its arguments and returns a Boolean value indicating whether the element should be kept.
 *
 * @return              The receiver.
 */
- (instancetype)filter:(BOOL (^)(KeyType key, ElementType value))predicate;

@end

NS_ASSUME_NONNULL_END
