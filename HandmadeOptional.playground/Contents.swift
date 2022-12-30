import Foundation

// 理解のために日本語で書いています
// 参考URL
// https://www.youtube.com/watch?v=_wA0FkBah6A&list=PLQ5rERkGSxF81eV-tFHxmtflz9dFrhgyY



//// 値のあるなしをenumで表す
//enum あるかも {
//    case ない
//    case ある(Int)
//}
//
//let maybe1: あるかも = .ない
//let maybe2: あるかも = .ある(10)
//
//func printNumber(maybe: あるかも) {
//    switch maybe {
//    case .ない:
//        print("値はありません")
//    case .ある(let num):
//        print("値はあります: ", num)
//    }
//}
//
//printNumber(maybe: .ない)
//printNumber(maybe: .ある(30))


//// あるかもを任意の型で表す、Optionalのコードを見てみる
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
////enum Optional<Wrapped> {
////    case none
////    case some(Wrapped)
////}
//
//あるかも<Int>.ある(10)
//Optional<Int>.some(10)
//// optionalコードのGitHub
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L121


//// switchを楽に書く、"if let文"
//let opt1: Int? = 10
////let opt1: Optional<Int> = .some(10)
//
//switch opt1 {
//case .some(let value):
//    print("値: ", value)
//case .none:
//    break
//}
//
//if case .some(let value) = opt1 {
//    print("値だ: ", value)
//}
//
//if let value = opt1 {
//    print("値やで: ", value)
//}


//// a!をswitchで書く(強制アンラップ)
//let a: Int? = nil
//
//switch a {
//case .some(let value):
//    print(value)
//case .none:
//    fatalError("a is nil")
//}

//switch a {
//case .some(let value):
//    print(value)
//case .none:
//    print("a is nil")
//}


//// nilで初期化
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//let opt1: Optional<Int> = nil
//let b: あるかも<Int> = nil
//print(b)
//
//extension あるかも: ExpressibleByNilLiteral {
//    init(nilLiteral: ()) {
//        self = .ない
//    }
//}


//// Tで初期化出来るようになる
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//let opt1 = Optional<Int>(10)
//let a = あるかも<Int>(10)
//let b = あるかも<Int>.ある(10)
//
//extension あるかも {
//    init(_ value: T) {
//        self = .ある(value)
//    }
//}


//// 比較できる型を作る
//struct Point {
//    var x: Int
//    var y: Int
//}
//
//Point(x: 0, y: 0) == Point(x: 0, y: 0)
//Point(x: 0, y: 0) == Point(x: 99, y: 99)
//
//extension Point {
//    // lhs: Left Hand Side
//    // rhs: Right Hand Side
//    // こちらの引数は、何を入れても大丈夫なもよう
//    static func == (lhs: Point, rhs: Point) -> Bool {
//        if lhs.x == rhs.x && lhs.y == rhs.y {
//            return true
//        } else {
//            return false
//        }
//    }
//}
//
//extension Point: Equatable {
//}


//// nilと比較できるようにする
//let a: Int? = 10
//if a == nil {
//    print("nil")
//} else {
//    print("not nil")
//}
//
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L505
//let c: あるかも<Int> = .ない
//if c == nil {
//    print("nil")
//} else {
//    print("not nil")
//}
//
//// nilと同等
//let n: _OptionalNilComparisonType = nil
//
//extension あるかも {
//    static func == (lhs: あるかも<T>, rhs: _OptionalNilComparisonType) -> Bool {
//        switch lhs {
//        case .ある:
//            return false
//        case .ない:
//            return true
//        }
//    }
//
//    static func == (lhs: _OptionalNilComparisonType, rhs: あるかも<T>) -> Bool {
//        switch rhs {
//        case .ある:
//            return false
//        case .ない:
//            return true
//        }
//    }
//}
//
//let d: あるかも<Int> = .ない
//if d == nil {
//    print("nil")
//} else {
//    print("not nil")
//}
//
//if nil == d {
//    print("nil")
//} else {
//    print("not nil")
//}
//
//let e: あるかも<Int> = .ある(10)
//if e == nil {
//    print("nil")
//} else {
//    print("not nil")
//}
//
//if nil == e {
//    print("nil")
//} else {
//    print("not nil")
//}


//// != でnilと比較できるようにする
//let a: Int? = 10
//
//if a != nil {
//    print("not nil")
//} else {
//    print("nil")
//}
//
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L536
//
//let c: あるかも<Int> = .ない
//
//if c != nil {
//    print("not nil")
//} else {
//    print("nil")
//}
//
//let n: _OptionalNilComparisonType = nil
//
//// nilだったら"nil"とprintするfunc
//func f1(_ n: _OptionalNilComparisonType) {
//    print("nil")
//}
//
//f1(nil)
//
//extension あるかも {
//    static func !=(lhs: あるかも<T>, rhs: _OptionalNilComparisonType) -> Bool {
//        switch lhs {
//        case .ある:
//            return true
//        case .ない:
//            return false
//        }
//    }
//    static func !=(lhs: _OptionalNilComparisonType, rhs: あるかも<T>) -> Bool {
//        switch rhs {
//        case .ある:
//            return true
//        case .ない:
//            return false
//        }
//    }
//}
//
//let d: あるかも<Int> = .ない
//if d != nil {
//    print("not nil")
//} else {
//    print("nil")
//}
//
//if nil != d {
//    print("not nil")
//} else {
//    print("nil")
//}
//
//
//let e: あるかも<Int> = .ある(10)
//if e != nil {
//    print("not nil")
//} else {
//    print("nil")
//}
//
//if nil != e {
//    print("not nil")
//} else {
//    print("nil")
//}


//// あるかも同士を比較する
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L399
//
//あるかも<Int>.ある(10) == あるかも<Int>.ある(10)
//あるかも<Int>.ある(10) == あるかも<Int>.ある(99)
//あるかも<Int>.ある(10) == あるかも<Int>.ない
//
////extension あるかも: Equatable {
////    static func == (lhs: あるかも<T>, rhs: あるかも<T>) -> Bool {
////        switch (lhs, rhs) {
////        case (.ある(let l), .ある(let r)):
////            if l == r {
////                return true
////            } else {
////                return false
////            }
////        case (.ない, .ない):
////            return true
////        case (.ある, .ない), (.ない, .ある):
////            return false
////        }
////    }
////}
//
//extension あるかも: Equatable where T: Equatable {
//    static func == (lhs: あるかも<T>, rhs: あるかも<T>) -> Bool {
//        switch (lhs, rhs) {
//        case (.ある(let l), .ある(let r)):
//            if l == r {
//                return true
//            } else {
//                return false
//            }
//        case (.ない, .ない):
//            return true
//        case (.ある, .ない), (.ない, .ある):
//            return false
//        }
//    }
//}
//
//// 比較できる型のみでプロパティが構成されたら"==func"を実装しなくて良い。String同士は比較できる、Int同士は比較できる。
//// なお、!= も自働的に実装される
//struct Person {
//    var name: String
//    var age: Int
//}
//
//Person(name: "さとう", age: 10) == Person(name: "さとう", age: 10)
//あるかも<Person>.ある(Person(name: "さとう", age: 10)) == あるかも<Person>.ある(Person(name: "さとう", age: 10))
//あるかも<Person>.ある(Person(name: "さとう", age: 10)) != あるかも<Person>.ある(Person(name: "さとう", age: 99))
//
//extension Person: Equatable{}


//// switchでnilと比較する
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//let b = あるかも<Int>.ない
//switch b {
//case nil:
//    print("nil")
//default:
//    print("not nil")
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L471
//
//// lhsがcase nil、rhsがあるかも<T>.ないを示している
//extension あるかも {
//    static func ~=(lhs: _OptionalNilComparisonType, rhs: あるかも<T>) -> Bool {
//        print("~=, lhs: \(lhs), rhs: \(rhs)")
//        switch rhs {
//        case .ある:
//            return false
//        case .ない:
//            return true
//        }
//    }
//}


//// 処理をクロージャーに包んで渡す
//func and(_ a: Bool, _ b: Bool) -> Bool {
//    print(#function, "start")
//    defer {
//        print(#function, "end")
//    }
//    if a == true {
//        if b == true {
//            return true
//        } else {
//            return false
//        }
//    } else {
//        return false
//    }
//}
//
////print("=======================")
////print(and(false, false))
////print(and(false, true))
////print(and(true, false))
////print(and(true, true))
//
//func fast(_ b: Bool) -> Bool {
//    print(#function, "start")
//    defer {
//        print(#function, "end")
//    }
//    return b
//}
//
//func slow(_ b: Bool) -> Bool {
//    print(#function, "start")
//    defer {
//        print(#function, "end")
//    }
//    sleep(3)
//    return b
//}
//
////print("=======================")
////print(and(fast(true), slow(true)))
//
//func andTwo(_ a: Bool, _ b: () -> Bool) -> Bool {
//    print(#function, "start")
//    defer {
//        print(#function, "end")
//    }
//    if a == true {
//        if b() == true {
//            return true
//        } else {
//            return false
//        }
//    } else {
//        return false
//    }
//}
//
////print("=======================")
////print(andTwo(fast(false), { slow(false) }))
////print(andTwo(fast(true), { slow(false) }))
//
//func andThree(_ a: Bool, _ b: @autoclosure () -> Bool) -> Bool {
//    print(#function, "start")
//    defer {
//        print(#function, "end")
//    }
//    if a == true {
//        if b() == true {
//            return true
//        } else {
//            return false
//        }
//    } else {
//        return false
//    }
//}
//
//print("=======================")
//print(andThree(fast(false), slow(false) ))
//print(andThree(fast(true), slow(false) ))


//// ??を自作する
//enum あるかも<T> {
//    case ない
//    case ある(T)
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L641
//
////あるかも<Int>.ない ?? { 10 }
////
////func ?? <T>(maybe: あるかも<T>, defaultValue: () -> T) -> T {
////    switch maybe {
////    case .ある(let value):
////        return value
////    case .ない:
////        return defaultValue()
////    }
////}
//
////あるかも<Int>.ない ?? 20
////あるかも<Int>.ある(10) ?? 20
//
//func ?? <T>(maybe: あるかも<T>, defaultValue: @autoclosure () -> T) -> T {
//    switch maybe {
//    case .ある(let value):
//        return value
//    case .ない:
//        return defaultValue()
//    }
//}
//
//func slow(_ n: Int) -> Int {
//        print(#function, "start")
//        defer {
//            print(#function, "end")
//        }
//    sleep(3)
//    return n
//}
//
//あるかも<Int>.ない ?? slow(20)
//あるかも<Int>.ある(10) ?? slow(20)


//// .mapを自作する
//enum あるかも<Wrapped> {
//    case ない
//    case ある(Wrapped)
//}
//
//// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L160
//
////let result5: あるかも<Int> = あるかも<Int>.ある(10).map {
////    $0 * 2
////}
//
//extension あるかも {
//    func map<U>(_ transform: (Wrapped) -> U) -> あるかも<U> {
//        switch self {
//        case .ある(let value):
//            return あるかも<U>.ある(transform(value))
//        case .ない:
//            return あるかも<U>.ない
//        }
//    }
//}
//
//let result6: あるかも<Int> = あるかも<Int>.ある(10).map { $0 * 2 }
//let result7: あるかも<Int> = あるかも<Int>.ない.map{ $0 * 2 }
//let result8: あるかも<String> = あるかも<Int>.ある(10).map { String($0) }


// .flatMapを自作する
enum あるかも<Wrapped> {
    case ない
    case ある(Wrapped)
}

// https://github.com/apple/swift/blob/main/stdlib/public/core/Optional.swift#L191

//let result5: あるかも<Int> = あるかも<Int>.ある(10).flatMap {
//    _ in return あるかも<Int>.ある(20)
//}

extension あるかも {
    func flatMap<U>(_ transform: (Wrapped) -> あるかも<U>) -> あるかも<U> {
        switch self {
        case .ある(let value):
            return transform(value)
        case .ない:
            return .ない
        }
    }
}

let result6: あるかも<Int> = あるかも<Int>.ある(10).flatMap { num in
    あるかも<Int>.ある(num * 2)
}

let result7: あるかも<Int> = あるかも<Int>.ある(10).flatMap { _ in
    あるかも<Int>.ない
}

let result8: あるかも<Int> = あるかも<Int>.ない.flatMap { num in
    あるかも<Int>.ある(num * 2)
}

let result9: あるかも<Int> = あるかも<Int>.ない.flatMap { _ in
    あるかも<Int>.ない
}
