//
//  ViewController.swift
//  DragDrop
//
//  Created by Nishanth P on 7/4/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

/*Abstract:
Demonstrates how to enable drag and drop for a UIImageView instance.
*/

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.borderColor = UIColor.green.cgColor
            imageView.layer.borderWidth = 0.0
        }
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.borderColor = UIColor.red.cgColor

        // For an image view, you must explicitly enable user interaction to allow drag and drop.
        imageView.isUserInteractionEnabled = true

        // Enable dragging from the image view (see ViewController+Drag.swift).
        let dragInteraction = UIDragInteraction(delegate: self)
        imageView.addInteraction(dragInteraction)

        // Enable dropping onto the image view (see ViewController+Drop.swift).
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
    }
}

#Drag
----------------------------------------------------------------------------------------------
extension ViewController: UIDragInteractionDelegate {
    // MARK: - UIDragInteractionDelegate

    /*
     The `dragInteraction(_:itemsForBeginning:)` method is the essential method
     to implement for allowing dragging from a view.
     */
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = imageView.image else { return [] }

        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image

        /*
         Returning a non-empty array, as shown here, enables dragging. You
         can disable dragging by instead returning an empty array.
         */
        return [item]
    }

    /*
     Code below here adds visual enhancements but is not required for minimal
     dragging support. If you do not implement this method, the system uses
     the default lift animation.
     */
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        guard let image = item.localObject as? UIImage else { return nil }

        // Scale the preview image view frame to the image's size.
        let frame: CGRect
        if image.size.width > image.size.height {
            let multiplier = imageView.frame.width / image.size.width
            frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: image.size.height * multiplier)
        } else {
            let multiplier = imageView.frame.height / image.size.height
            frame = CGRect(x: 0, y: 0, width: image.size.width * multiplier, height: imageView.frame.height)
        }

        // Create a new view to display the image as a drag preview.
        let previewImageView = UIImageView(image: image)
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.frame = frame

        // Provide a custom targeted drag preview.
        let target = UIDragPreviewTarget(container: imageView, center: imageView.center)
        return UITargetedDragPreview(view: previewImageView, parameters: UIDragPreviewParameters(), target: target)
    }
}


# Drop
--------------------------------------------------------------------------------------------------

import UIKit
import Foundation
import MobileCoreServices

extension ViewController: UIDropInteractionDelegate {
    // MARK: - UIDropInteractionDelegate

    /**
     Ensure that the drop session contains a drag item with a data representation
     that the view can consume.
     */
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
    }

    // Update UI, as needed, when touch point of drag session enters view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }

    /**
     Required delegate method: return a drop proposal, indicating how the
     view is to handle the dropped items.
     */
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)

        let operation: UIDropOperation

        if imageView.frame.contains(dropLocation) {
            /*
             If you add in-app drag-and-drop support for the .move operation,
             you must write code to coordinate between the drag interaction
             delegate and the drop interaction delegate.
             */
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            // Do not allow dropping outside of the image view.
            operation = .cancel
        }

        return UIDropProposal(operation: operation)
    }

    /**
     This delegate method is the only opportunity for accessing and loading
     the data representations offered in the drag item.
     */
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Consume drag items (in this example, of type UIImage).
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]

            /*
             If you do not employ the loadObjects(ofClass:completion:) convenience
             method of the UIDropSession class, which automatically employs
             the main thread, explicitly dispatch UI work to the main thread.
             For example, you can use `DispatchQueue.main.async` method.
             */
            self.imageView.image = images.first
        }

        // Perform additional UI updates as needed.
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }

    // Update UI, as needed, when touch point of drag session leaves view.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }

    // Update UI and model, as needed, when drop session ends.
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }

    // MARK: - Helpers

    func updateLayers(forDropLocation dropLocation: CGPoint) {
        if imageView.frame.contains(dropLocation) {
            view.layer.borderWidth = 0.0
            imageView.layer.borderWidth = 2.0
        } else if view.frame.contains(dropLocation) {
            view.layer.borderWidth = 5.0
            imageView.layer.borderWidth = 0.0
        } else {
            view.layer.borderWidth = 0.0
            imageView.layer.borderWidth = 0.0
        }
    }
}


