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


