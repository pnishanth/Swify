//
//
//  Try Vision
//
//  Created by Nishanth P.
//  Copyright © 2018 Nishapp. All rights reserved.
//

//Set Up Vision with a Core ML Model

let model = try VNCoreMLModel(for: MobileNet().model)

let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
    self?.processClassifications(for: request, error: error)
})
request.imageCropAndScaleOption = .centerCrop
return request


//Run the Vision Request

DispatchQueue.global(qos: .userInitiated).async {
    let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
    do {
        try handler.perform([self.classificationRequest])
    } catch {
        /*
         This handler catches general image processing errors. The `classificationRequest`'s
         completion handler `processClassifications(_:error:)` catches errors specific
         to processing that request.
         */
        print("Failed to perform classification.\n\(error.localizedDescription)")
    }
}

//Handle Image Classification Results

func processClassifications(for request: VNRequest, error: Error?) {
    DispatchQueue.main.async {
        guard let results = request.results else {
            self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
            return
        }
        // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.
        let classifications = results as! [VNClassificationObservation]
