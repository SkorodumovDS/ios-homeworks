//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 27.07.2023.
//

import Foundation

final class FeedViewModel {
    
    enum Action {
        case viewReady
        case passwordButtonTapped
        case nextButtonTapped
    }
    
    enum State{
        
        case initial
        case passwordChecked
        case passwordUnchecked
        case nextScreen
    }
    
    private let feedModel : FeedModel
    
    var stateChanged : ((State) -> Void)?
    
    private(set) var state : State = .initial {
        didSet {
            stateChanged?(state)
            
        }
    }
    private let coordinator : FeedFlowCoordinator
    var secret: String = ""
    
    init(feedModel: FeedModel, coordinator: FeedFlowCoordinator) {
        self.feedModel = feedModel
        self.coordinator = coordinator
    }
    
    func changeState(_ action : Action) {
        switch action {
        case.viewReady:
            state = .initial
        case .nextButtonTapped:
            //state = .nextScreen
            coordinator.showNextScreen()
        case .passwordButtonTapped :
            feedModel.check(secret: self.secret, completion: {
                [weak self] result in switch result {
                case .success(let answer):
                    if answer == true {self?.state = .passwordChecked}
                    else {self?.state = .passwordUnchecked}
                case .failure(let appError):
                    if appError == AppError.wrongPassword {
                        self?.state = .passwordUnchecked}
                }
            })
        }
    }
}
