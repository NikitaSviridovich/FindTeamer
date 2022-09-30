//
//  RootViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 12.09.22.
//

import Firebase
import Combine

final class RootViewModel: ObservableObject {
    // MARK: Publishers
    @Published var isAuthorized: Bool = false
    // MARK: Private fields
    private var cancellable: AnyCancellable!
    private var authManager: AuthManager
    // MARK: Initializator
    public init(authManager: AuthManager) {
        self.authManager = authManager
        cancellable = self.authManager.isAuthorizedPublisher.sink { [weak self] isAuthorized in
        guard let strongSelf = self else { return }
            strongSelf.isAuthorized = isAuthorized
        }
    }
}
