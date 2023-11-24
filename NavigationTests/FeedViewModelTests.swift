//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Skorodumov Dmitry on 24.11.2023.
//

import XCTest

final class FeedViewModelTests: XCTestCase {
    
    enum State{
        
        case initial
        case passwordChecked
        case passwordUnchecked
        case nextScreen
    }
    enum testError : Error {
        case someError
    }
    private var state : State = .initial
    let feedModel = FeedModelMock()
    
    func checkResult(secret: String) -> Void {
        feedModel.check(secret: secret, completion: {
            [weak self] result in switch result {
            case .success(let answer):
                if answer == true {self?.state = .passwordChecked}
                else {self?.state = .passwordUnchecked}
            case .failure(let appError):
                self?.state = .passwordUnchecked
            }
        })
    }
    
    func testSucsessResult() {
        feedModel.fakeResult = Result.success(true)
        checkResult(secret: "password")
        XCTAssertEqual(self.state, State.passwordChecked)
    }
    
    func testFailureResult() {
        feedModel.fakeResult = Result.failure(testError.someError)
        checkResult(secret: "password")
        XCTAssertEqual(self.state, State.passwordUnchecked)
    }
    
    func testUncheckedPasswordResult() {
        feedModel.fakeResult = Result.success(false)
        checkResult(secret: "password")
        XCTAssertEqual(self.state, State.passwordUnchecked)
    }
}
