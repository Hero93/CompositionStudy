//
//  ViewController.swift
//  CompositionStudy
//
//  Created by Luca LG. Gramaglia on 06/02/2020.
//  Copyright © 2020 e-Gate. All rights reserved.
//

import UIKit

protocol FeedLoader {
    func loadFeed(completion: ([String]) -> Void)
}

struct Reachability {
    static let networkAvailable: Bool = false
}

class FeedVC: UIViewController {
    
    // MARK: - IVars
    
    // The easier way to load data from cache when internet connection is not available it's to
    // depend on concrete type again (RemoteFeedLoader) & (LocalFeedLoader) instead of an interface.
    
    var remote: RemoteFeedLoader!
    var local: LocalFeedLoader!

    // MARK: - Init

    convenience init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.init()
        self.local = local
        self.remote = remote
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We need to enter the logic to load data from cache when internet is not available inside the view controller.
        // But, by doing this, I can't change the behaviour of the view controller without changing the internal code -> vc not open to extension.
        
        if Reachability.networkAvailable {
            remote.loadFeed { feed in }
        } else {
            local.loadFeed { feed in }
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    
    // Some people might add some logic to load data from cache if internet connection is not available
    // -> By doing this when break the Single Responsability Principle.
    
    func loadFeed(completion: ([String]) -> Void) {
        // TODO: call web service or mock
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: ([String]) -> Void) {
        // TODO: load data from persistence store or mock
    }
}
