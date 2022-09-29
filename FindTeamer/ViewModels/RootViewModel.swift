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
    private var firebaseAuthManager: FirebaseAuthManager
    // MARK: Initializator
    public init(firebaseAuthManager: FirebaseAuthManager = FirebaseAuthManager()) {
        self.firebaseAuthManager = firebaseAuthManager
        cancellable = firebaseAuthManager.$isAuthorized.sink { [weak self] isAuthorized in
        guard let strongSelf = self else { return }
            strongSelf.isAuthorized = isAuthorized
        }
    }
}
