import Foundation


class Test2ViewModel {
    
    private let name: String
    private let age: String
    private let weight: String
    
    init(name: String, age: String, weight: String) {
        self.name = name
        self.age = age
        self.weight = weight
    }
    
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        print(name)
        print(age)
        print(weight)
        
        return Output()
    }
}
