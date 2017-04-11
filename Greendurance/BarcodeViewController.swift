//
//  BarcodeViewController.swift
//  Greendurance
//
//  Created by Pujita Tipnis on 4/8/17.
//  Copyright © 2017 Pujita Tipnis. All rights reserved.
//

import AVFoundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
        var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
    
        let points = Points()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor.black
            captureSession = AVCaptureSession()
            
            let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                failed();
                return;
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
            } else {
                failed()
                return
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
            previewLayer.frame = view.layer.bounds;
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            view.layer.addSublayer(previewLayer);
            
            captureSession.startRunning();
        }
        
        func failed() {
            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            captureSession = nil
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if (captureSession?.isRunning == false) {
                captureSession.startRunning();
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            if (captureSession?.isRunning == true) {
                captureSession.stopRunning();
            }
            
            self.navigationController?.popViewController(animated: true)
            //print("Total is \(points.total)")
            //self.performSegue(withIdentifier: "barcodeSuccessSegue", sender: points)
        }
        
        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
            captureSession.stopRunning()
            
            if let metadataObject = metadataObjects.first {
                let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
                
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: readableObject.stringValue);
            }
            
            dismiss(animated: true)
        }
        
        func found(code: String) {
            //print(code)
            
            let ref = FIRDatabase.database().reference().child("products")
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                //print(snapshot.childrenCount)
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                    //print(rest.value!)
                    
                    let product = Product()
                    product.imageURL = (rest.value! as AnyObject)["image_url"] as! String
                    product.productName = (rest.value! as AnyObject)["product_name"] as! String
                    product.packaging = (rest.value! as AnyObject)["packaging"] as! String
                    product.green = (rest.value! as AnyObject)["green"] as! Int
                    //print((rest.value! as AnyObject)["code"])
                    let barcode = NSString(format: "%@", (rest.value! as AnyObject)["code"] as! CVarArg) as String
                    product.code = barcode
                    
                    //print("\(NSString(format: "%@", barcode as! CVarArg) as String) and \(code)")
                    if "\(barcode)" == "\(code)" {
                        //print ("Match found")
                        
                        var total : Int = 0
                        
                        if (product.packaging.contains("vegetable")) {
                            //product.green += 15
                            product.disposalCategory = "compost"
                            
                        } else if (product.packaging.contains("glass")) {
                            //product.green += 10
                            product.disposalCategory = "trash"
                            
                        } else if (product.packaging.contains("paper")) {
                            //product.green += 15
                            product.disposalCategory = "recycle"
                            
                        } else if (product.packaging.contains("plastic")) {
                            //product.green += 5
                            product.disposalCategory = "recycle"
                            
                        } else if (product.packaging.contains("can")) {
                            //product.green += 5
                            product.disposalCategory = "recycle"
                            
                        }
                        
                        let prodref = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("products").childByAutoId()
                        
                        let productSelected = ["productName" : product.productName,
                                               "packaging" : product.packaging,
                                               "disposalCategory" : product.disposalCategory,
                                               "key" : prodref.key]
                        
                        prodref.setValue(productSelected)
                        
                        let totalRef = FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid)
                        totalRef.observeSingleEvent(of: .value, with: { (snapshot) in
                            
                            total = (snapshot.value! as AnyObject)["total"] as! Int
                            total += product.green 
                            print ("Total: \(total)")
                            
                            let childUpdates = ["/total" : total]
                            print("Child Update: \(childUpdates)")
                            totalRef.updateChildValues(childUpdates)
                            
                            self.points.total = total
                            //print("Total is \(self.points.total)")
                            //self.navigationController?.popViewController(animated: true)
                            self.performSegue(withIdentifier: "barcodeSuccessSegue", sender: self.points)
                        })
                        
                    }
                    
                }
            })
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "barcodeSuccessSegue" {
            let nextVC = segue.destination as! GroceriesModalViewController
            nextVC.points = sender as! Points
        }
    }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    }
