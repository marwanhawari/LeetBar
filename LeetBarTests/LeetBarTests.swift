//
//  LeetBarTests.swift
//  LeetBarTests
//
//  Created by Marwan Hawari on 8/5/22.
//

import XCTest
@testable import LeetBar

@MainActor
class LeetBarTests: XCTestCase {
    
    var vm: ViewModel!
    
    func test_ViewModel_fetchData_expectValues() async throws {
        vm = ViewModel(service: MockLeetServiceWithData())
        
        assertInitialization(viewModel: vm)

        try await vm.fetchUserData(refreshEvent: .openMenu)
        
        XCTAssertEqual(vm.dailyProblemLink, "https://leetcode.com/problems/mock-link/")
        XCTAssertEqual(vm.dailyProblemDifficultyColor, .mediumColor)
        XCTAssertEqual(vm.dailyProblemString, "100. Mock Question Title")
        
        XCTAssertEqual(vm.easyTotal, 586)
        XCTAssertEqual(vm.easyAngleEnd, 15.699, accuracy: 0.01) // TODO: .
        XCTAssertEqual(vm.mediumTotal, 1257)
        XCTAssertEqual(vm.mediumAngleEnd, 45.419, accuracy: 0.01) // TODO: .
        XCTAssertEqual(vm.hardTotal, 519)
        XCTAssertEqual(vm.hardAngleEnd, 47.553, accuracy: 0.01) // TODO: .
        
    }
    
    func test_ViewModel_fetchData_nilValues() async throws {
        vm = ViewModel(service: MockLeetServiceNil())
        
        assertInitialization(viewModel: vm)
        
        try await vm.fetchUserData(refreshEvent: .openMenu)
  
        assertInitialization(viewModel: vm)
        
    }
    
    func assertInitialization(viewModel: ViewModel) {
        XCTAssertEqual(vm.dailyProblemLink, "", "dailyProblemLink")
        XCTAssertEqual(vm.dailyProblemDifficultyColor, .primary, "dailyProblemDifficultyColor")
        XCTAssertEqual(vm.dailyProblemString, "                              ", "dailyProblemString")
        XCTAssertEqual(vm.easyTotal, 0, "easyTotal")
        XCTAssertEqual(vm.mediumTotal, 0, "mediumTotal")
        XCTAssertEqual(vm.hardTotal, 0, "hardTotal")
    }
    
}
