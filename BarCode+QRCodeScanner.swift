//
//  ViewController.swift
//  ScanBarCode/QRCode
//
//  Created by Nishanth P on 11/1/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//


import UIKit
import AVFoundation


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var image: UIImageView!
    var captureSession: AVCaptureSession!
    var captureDevice: AVCaptureDevice!
    var captureDeviceInput: AVCaptureDeviceInput!
    var captureDeviceOutput: AVCaptureMetadataOutput!
    var capturePreviewLayer: AVCaptureVideoPreviewLayer!
    var alertController: UIAlertController!
    
    
    func initializeScanner() {
        captureSession = AVCaptureSession()
        
        do {
            // get the default device and use auto settings
            captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            try captureDevice.lockForConfiguration()
            captureDevice.exposureMode = AVCaptureExposureMode.continuousAutoExposure
            captureDevice.whiteBalanceMode = AVCaptureWhiteBalanceMode.continuousAutoWhiteBalance
            captureDevice.focusMode = AVCaptureFocusMode.continuousAutoFocus
            if captureDevice.hasTorch {
                captureDevice.torchMode = AVCaptureTorchMode.auto
            }
            captureDevice.unlockForConfiguration()
            
            // add the input/output devices
            captureSession.beginConfiguration()
            captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            
            // AVCaptureMetadataOutput is how we can determine
            captureDeviceOutput = AVCaptureMetadataOutput()
            captureDeviceOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            if captureSession.canAddOutput(captureDeviceOutput) {
                captureSession.addOutput(captureDeviceOutput)
                captureDeviceOutput.metadataObjectTypes = captureDeviceOutput.availableMetadataObjectTypes
            }
            captureSession.commitConfiguration()
        }
        catch {
            displayAlert("Error", message: "Unable to set up the capture device.")
        }
        
        capturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        capturePreviewLayer.frame = self.view.layer.bounds
        capturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(capturePreviewLayer)
        self.view.addSubview(image)
        
        
        
    }
    private func updatePreviewLayer(layer: AVCaptureConnection,orientation: AVCaptureVideoOrientation){
        
        layer.videoOrientation = orientation
        capturePreviewLayer.frame = self.view.bounds
    }
    
    
    func startScanner() {
        if captureSession != nil {
            captureSession.startRunning()
        }
    }
    
    func stopScanner() {
        if captureSession != nil {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeScanner()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScanner()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopScanner()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let connection = self.capturePreviewLayer?.connection{
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            if(previewLayerConnection.isVideoOrientationSupported){
                
                switch(orientation){
                case .portrait:updatePreviewLayer(layer: previewLayerConnection,orientation:.portrait)
                    break
                case .landscapeRight:updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                    break
                case .landscapeLeft:updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                    break
                case .portraitUpsideDown:updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                    break
                default:updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                    
                }
            }
            
        }
        
    }
    
    
    
    
    func displayAlert(_ title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            self.alertController = nil
           
        })
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /* AVCaptureMetadataOutputObjectsDelegate */
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if alertController != nil {
            return
        }
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            if let machineReadableCode = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                
                let barcode = machineReadableCode.stringValue
                
                    let title = "Image Scanned"
                    self.displayAlert(title, message:"\(barcode)")
                }
            }
        }
        
    }
    
    
   
