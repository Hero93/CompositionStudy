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

class FeedVC: UIViewController {
    var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { feed in
            
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
