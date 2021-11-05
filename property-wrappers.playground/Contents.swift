import UIKit

class MyClass {
    
    private var property: Int = 0
    
    var myProperty: Int {
        get {
            print("\(Date()). myProperty read: \(property)")
            return property
        }
        set {
            print("\(Date()). myProperty set to: \(newValue)")
            property = newValue
        }
    }
}
 


struct Logged<Value> {
    
    private var value: Value
    
    init(_ value: Value) {
        self.value = value
    }
    
    public func get() -> Value {
        print("\(Date()). myProperty read: \(value)")
        return value
    }
    
    public mutating func set(_ newValue: Value) {
        print("\(Date()). myProperty set to: \(newValue)")
        value = newValue
    }
}

class MyClass2 {
    var myProperty = Logged<Int>(0)
}

@propertyWrapper
struct Logged2<Value> {
    
    public var wrappedValue: Value {
        get { get() }
        set { set(newValue) }
    }
    
    private var value: Value
    private let dateFormatter: DateFormatter
    
    init(wrappedValue: Value, formatString: String) {
        self.value = wrappedValue
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = formatString
    }
    
    public func get() -> Value {
        let dateString = dateFormatter.string(from: Date())
        print("\(dateString). myProperty read: \(value)")
        return value
    }
    
    public mutating func set(_ newValue: Value) {
        let dateString = dateFormatter.string(from: Date())
        print("\(dateString). myProperty set to: \(newValue)")
        value = newValue
    }
}

class MyClass3 {
    @Logged2(formatString: "HH:mm dd.MM.yyyy") var myProperty = 0
}

let myClass = MyClass()
let property = myClass.myProperty //get
myClass.myProperty = 1 //set


let myClass2 = MyClass2()
let property2 = myClass2.myProperty.get() //getter
myClass2.myProperty.set(5) //setter

let myClass3 = MyClass3()
let property3 = myClass3.myProperty //getter
myClass3.myProperty = 7 //setter


@propertyWrapper
struct UserDefault<T> {
    private let key: String
    
    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: self.key) as? T }
        set { UserDefaults.standard.setValue(newValue, forKey: self.key)}
    }
    
    init(key: String) {
        self.key = key
    }
}

class MyClass4 {
    @UserDefault(key: "login") var login: String?
}

let myClass4 = MyClass4()
myClass4.login
myClass4.login = "test@test.ru"



