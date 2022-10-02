//
//  RootViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import Firebase
import Combine

final class RootViewModel: ObservableObject {
    // MARK: - Public properties
    @Published private(set) var isAuthorized: Bool = false
    
    // MARK: - Private properties
    private var cancellable = Set<AnyCancellable>()
    private let authManager: AuthManager
    
    // MARK: - Initializators
    public init(authManager: AuthManager) {
        self.authManager = authManager
        authManager.observeAuthenticationChanges()
            .map { $0 != nil }
            .assign(to: &$isAuthorized)
    }
}
