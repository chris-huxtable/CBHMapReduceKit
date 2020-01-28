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

@interface NSOrderedSet<ElementType> (CBHMapReduceKit)

#pragma mark - Mapping

/** Returns a new ordered set containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new ordered ordered set of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSOrderedSet<id> *)orderedSetByMapping:(nullable id (^)(ElementType object))transform;

/** Returns a new mutable set containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new mutable ordered set of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSMutableOrderedSet<id> *)mutableOrderedSetByMapping:(nullable id (^)(ElementType object))transform;


/** Returns a new array containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new array of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSArray<id> *)arrayByMapping:(nullable id (^)(ElementType object))transform;

/** Returns a new mutable array containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new mutable array of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSMutableArray<id> *)mutableArrayByMapping:(nullable id (^)(ElementType object))transform;


/** Returns a new set containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new set of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSSet<id> *)setByMapping:(nullable id (^)(ElementType object))transform;

/** Returns a new mutable set containing the non-`nil` results of calling the given transformation with each element of this sequence.
 *
 * @param transform     A closure that accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
 *
 * @return              A new mutable set of the non-`nil` results of calling `transform` with each element of the sequence.
 */
- (NSMutableSet<id> *)mutableSetByMapping:(nullable id (^)(ElementType object))transform;


#pragma mark - Filtering

/** Returns a new ordered set containing the elements of the set that satisfy the given predicate.
 *
 * @param predicate     A closure that takes an element as its argument and returns a Boolean value indicating whether the element should be included in the returned set.
 *
 * @return              A new ordered set of the elements that `predicate` allows.
 */
- (NSOrderedSet<ElementType> *)orderedSetByFiltering:(BOOL (^)(ElementType object))predicate;

/** Returns a new mutable ordered set containing the elements of the set that satisfy the given predicate.
 *
 * @param predicate     A closure that takes an element as its argument and returns a Boolean value indicating whether the element should be included in the returned set.
 *
 * @return              A new mutable ordered set of the elements that `predicate` allows.
 */
- (NSMutableOrderedSet<ElementType> *)mutableOrderedSetByFiltering:(BOOL (^)(ElementType object))predicate;


#pragma mark - Reducing

/** Returns the result of combining the elements of the sequence using the given closure.
 *
 * @param initial   The value to use as the initial accumulating value.
 * @param reduce    A closure that returns a new accumulating value resultant from the combination of whats already been accumulated with an element of the sequence.
 *
 * @return          The final accumulated value. If the sequence has no elements, the result is `initial`.
 */
- (nullable id)initial:(nullable id)initial reduce:(nullable id (^)(id __nullable memo, ElementType object))reduce;


#pragma mark - Collection Conversion

/** Maps the receiver to a new set.
 *
 * @return The receiver converted to a new mutable set.
 */
- (NSSet<ElementType> *)toSet;

/** Maps the receiver to a new mutable set.
 *
 * @return The receiver converted to a new mutable set.
 */
- (NSMutableSet<ElementType> *)toMutableSet;


/** Maps the receiver to a new array.
 *
 * @return The receiver converted to a new mutable array.
 */
- (NSArray<ElementType> *)toArray;

/** Maps the receiver to a new mutable ordered set.
 *
 * @return The receiver converted to a new mutable ordered set.
 */
- (NSMutableArray<ElementType> *)toMutableArray;

@end


@interface NSMutableOrderedSet<ElementType> (CBHMapReduceKit)

#pragma mark - Mapping

/** Maps the receiver so that it contains the results of a given closure over each of it's elements.
 *
 * @param transform     A closure that accepts an element of the receiver as its parameter and returns a transformed value of the same type.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the element type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)map:(ElementType (^)(ElementType object))transform;

/** Maps the receiver so that it contains the non-`nil` results of a given closure over each of it's elements.
 *
 * @param transform     A closure that accepts an element of the receiver as its parameter and returns a transformed value of the same type or `nil`.
 *
 * @return              The receiver.
 *
 * @warning             It is possible to transform the element type but this may cause issues if the sequence is used by a reference that expects only the original type.
 */
- (instancetype)compactMap:(nullable ElementType (^)(ElementType object))transform;


#pragma mark - Filtering

/** Filters the receiving ordered set so that it contains only the elements that satisfy the given predicate.
 *
 * @param predicate     A closure that takes an element as its argument and returns a Boolean value indicating whether the element should be kept.
 *
 * @return              The receiver.
 */
- (instancetype)filter:(BOOL (^)(ElementType object))predicate;

@end

NS_ASSUME_NONNULL_END
