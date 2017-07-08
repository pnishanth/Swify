//
//  ViewController.swift
//  PeekAndPop-3DTouch
//
//  Created by Nishanth P on 7/8/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//
class ViewController : UIViewController,UIViewControllerPreviewingDelegate,UITableViewDelegate,UITableViewDataSource {

  //  Example for tableView
  //  Add Necessary TableView functions conforming to UITableViewDelegate and UITableViewDataSource

    var tableView : UITableView = UITableView()

override func viewDidLoad() {
    super.viewDidLoad()

    registerForPreviewingWithDelegate(self, sourceView: tableView)
    tableView.delegate = self
    tableView.dataSource = self
    self.view.addSubView(tableView)
    
}

// PreviewView Controller - PEEK

func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    if let indexPath = tableView.indexPathForRowAtPoint(location) {
        previewingContext.sourceRect = tableView.rectForRowAtIndexPath(indexPath)
        return viewControllerForIndexPath(indexPath)
    }
    return nil
}

// CommitViewController - POP

func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
    presentViewController(viewControllerToCommit, animated: true, completion: nil)
}

// Override PreviewActionItem
override func previewActionItems() -> [UIPreviewActionItem] {
    return []
}

// Preview action Item Protocol
@available(iOS 9.0, *)
public protocol UIPreviewActionItem : NSObjectProtocol {
    public var title: String { get }
}

// Preview Action

let action = UIPreviewAction("Action1", style: .Default) { (action, viewController) in
    print("Action1 button Touched")
}

// Preview Action Group
let actionGroup = UIPreviewActionGroup("Look at me, I can grow!", style: .Default, actions: [action1, action2, action3]){

}

}
