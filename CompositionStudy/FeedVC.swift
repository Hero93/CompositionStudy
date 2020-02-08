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
    
    // MARK: - IVars
    
    var loader: FeedLoader!

    // MARK: - Init

    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        loader.loadFeed { feed in
            print(feed)
        }
    }
}

let feedVC = FeedVC(loader: LocalFeedLoader())
let feedVC2 = FeedVC(loader: RemoteFeedLoader())
let feedVC3 = FeedVC(loader: RemoteWithLocalFallbackFeedLoader(remote: RemoteFeedLoader(), local: LocalFeedLoader()))

struct Reachability {
    static let networkAvailable: Bool = false
}

class RemoteWithLocalFallbackFeedLoader: FeedLoader {
    
    // The best way to handle the feed load based on the internet connection it's using "Composition".
    // We encapsulate the logic of loading the feed to a new class called "RemoteWithLocalFallbackFeedLoader".
    
    // "RemoteWithLocalFallbackFeedLoader" composes the 2 concrete types "RemoteFeedLoader" & "LocalFeedLoader".
    
    // By making this class conform to the "FeedLoader" protocol, we can plug it to the "FeedVC" so the view controller
    // remains agnostic from the origin of the feed.
    
    // Even "RemoteFeedLoader" and "LocalFeedLoader" are agnostic to this class type.

    // The "FeedVC" doesn't care where the feed is coming, so we can now test the "FeedVC" very easily.
    
    
    let remote: RemoteFeedLoader // 1st concrete type
    let local: LocalFeedLoader // 2nd concrete type
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: ([String]) -> Void) {
        
        if Reachability.networkAvailable {
            remote.loadFeed(completion: completion)
        } else {
            local.loadFeed(completion: completion)
        }
    }
}

class RemoteFeedLoader: FeedLoader {
        
    func loadFeed(completion: ([String]) -> Void) {
        // TODO: call web service or mock
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: ([String]) -> Void) {
        // TODO: load data from persistence store or mock
    }
}
