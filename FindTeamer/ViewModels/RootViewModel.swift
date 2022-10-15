//
//  RootViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import Combine
import SwiftUI

final class RootViewModel: ObservableObject {
    // MARK: - Private properties
    @Published private(set) var isAuthorized: Bool = false
    private var cancellable = Set<AnyCancellable>()
    private let authManager: AuthManager
    
    // MARK: - Initializators
    public init(authManager: AuthManager) {
        self.authManager = authManager
        authManager.observeAuthenticationChanges()
            .assign(to: &$isAuthorized)
    }
}
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
