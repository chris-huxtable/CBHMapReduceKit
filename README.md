# CBHMapReduceKit

[![release](https://img.shields.io/github/release/chris-huxtable/CBHMapReduceKit.svg)](https://github.com/chris-huxtable/CBHMapReduceKit/releases)
[![pod](https://img.shields.io/cocoapods/v/CBHMapReduceKit.svg)](https://cocoapods.org/pods/CBHMapReduceKit)
[![licence](https://img.shields.io/badge/licence-ISC-lightgrey.svg?cacheSeconds=2592000)](https://github.com/chris-huxtable/CBHMapReduceKit/blob/master/LICENSE)
[![coverage](https://img.shields.io/badge/coverage-100%25-brightgreen.svg?cacheSeconds=2592000)](https://github.com/chris-huxtable/CBHMapReduceKit)

`CBHMapReduceKit` adds  map, filter, and reduce methods to `NSArray`, `NSSet`, `NSOrderedSet`,  `NSDictionary` and `NSEnumerator`. 


## Examples

### Mapping:
```objective-c
NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
NSArray<NSString *> *mapping = [array arrayByMapping:^id(NSNumber *object) {
	NSUInteger value = [object unsignedIntValue];
	return [NSString stringWithFormat:@"%lu", value + value];
}];
/// mapping => @[@"2", @"4", @"6", @"8", @"10", @"12" @"14", @"16", @"18", @"20"];
```

### Filtering:
```objective-c
NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
NSArray<NSNumber *> *filtered = [array arrayByFiltering:^BOOL(NSNumber *object) {
	return ( [object unsignedIntValue] % 2 == 0 );
}];
/// filtered => @[@2, @4, @6, @8, @10];
```

### Reducing:
```objective-c
NSArray<NSNumber *> *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
NSNumber *reduction = [array initial:@0 reduce:^NSNumber *(NSNumber *memo, NSNumber *object) {
	return @([memo unsignedIntegerValue] + [object unsignedIntValue]);
}];
/// reduction => @55;
```


## Brief Outline of Methods

### Mapping :

#### To `NSArray`:
```objective-c
- (NSArray<id> *)arrayByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableArray<id> *)mutableArrayByMapping:(nullable id (^)(ObjectType object))block;
```

#### To `NSSet` :
```objective-c
- (NSSet<id> *)setByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableSet<id> *)mutableSetByMapping:(nullable id (^)(ObjectType object))block;
```

#### To `NSOrderedSet`:
```objective-c
- (NSOrderedSet<id> *)orderedSetByMapping:(nullable id (^)(ObjectType object))block;
- (NSMutableOrderedSet<id> *)mutableOrderedSetByMapping:(nullable id (^)(ObjectType object))block;
```


### Filtering:

#### To `NSArray`:
```objective-c
- (NSArray<ObjectType> *)arrayByFiltering:(BOOL (^)(ObjectType object))block;
- (NSMutableArray<ObjectType> *)mutableArrayByFiltering:(BOOL (^)(ObjectType object))block;
```

#### To `NSSet`:
```objective-c
- (NSSet<ObjectType> *)setByFiltering:(BOOL (^)(ObjectType object))block;
- (NSMutableSet<ObjectType> *)mutableSetByFiltering:(BOOL (^)(ObjectType object))block;
```

#### To `NSOrderedSet`:
```objective-c
- (NSOrderedSet<ObjectType> *)orderedSetByFiltering:(BOOL (^)(ObjectType object))block;
- (NSMutableOrderedSet<ObjectType> *)mutableOrderedSetByFiltering:(BOOL (^)(ObjectType object))block;
```


### Reduce:

```objective-c
- (nullable id)initial:(nullable id)initial reduce:(nullable id (^)(id __nullable memo, ObjectType object))reduce;
```


## Licence
CBHMapReduceKit is available under the [ISC license](https://github.com/chris-huxtable/CBHMapReduceKit/blob/master/LICENSE).
