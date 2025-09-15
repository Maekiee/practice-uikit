import Foundation
import RxSwift
import RxCocoa


final class WishListViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchBarTapped: ControlEvent<Void>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
//        input.searchBarTapped
//            .bind
        
        return Output()
    }
    
}
