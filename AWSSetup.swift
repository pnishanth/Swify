//
//  AWSSetupController.swift
//  AWSSetupController
//
//  Created by Nishanth P on 10/3/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import AWSCore
import AWSCognito
import AWSS3

class AWSSetupController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up in App delegate is preferred.
        
        let myIdentityPoolId = "POOLID"
        let credentialsProvider:AWSCognitoCredentialsProvider = AWSCognitoCredentialsProvider(regionType:AWSRegionType.USEast1, identityPoolId: myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.USEast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        AWSS3.registerS3WithConfiguration(configuration, forKey: "defaultKey")
        let s3 = AWSS3.S3ForKey("defaultKey")
        
        // List the objects in AWSS3 Bucket
        
        let listRequest: AWSS3ListObjectsRequest = AWSS3ListObjectsRequest()
        listRequest.bucket = "Bucket"
        
        s3.listObjects(listRequest).continueWithBlock { (task) -> AnyObject? in
            
            for object in (task.result?.contents)! {
                
                print("Object key = \(object.key!)")
            }
            
            return nil
        }
        
        //AWSS3 Transfer Utility - files can be downloaded and uploaded using this method
        //Code to follow.
        
        
        
        
        
    }
  }
