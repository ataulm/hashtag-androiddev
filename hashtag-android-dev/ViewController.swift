import UIKit

class ViewController: UIViewController {
    
    let feedService = FeedService()

    override func viewDidLoad() {
        super.viewDidLoad()
        feedService.fetchFeed() { feedItems in
            print("viewDidLoad feedService fetched all the feedItems, count: " + String(feedItems.count))
        }
    }
}

