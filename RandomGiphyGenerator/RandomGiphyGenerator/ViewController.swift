//
//  ViewController.swift
//  RandomGiphyGenerator
//
//  Created by Rutkoski,Augustus on 9/13/17.
//  Copyright © 2017 heb. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftGifOrigin
import AlamofireObjectMapper
import ObjectMapper


/*
 
 Giphy API Docs: https://developers.giphy.com/docs/
 
 Challenges:
 
    Difficult - Easy
     * Style the UI
     * Change the mapping in GIFObject.GIFData.image_url to use different urls in response(some load slower but look better)
    
    Difficult - Medium
     * Lock button while image is loading so multiple calls are being loaded
     * Add a progress spinner so the user knows the image is loading(UI Activity Indicator)
 
    Difficult - Hard
     * Display multiple gifs
     * Change the way the image loads from square view to circle or any other shape
 
*/

class ViewController: UIViewController {

    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var gifSearchTextField: UITextField!
    @IBOutlet var generateButton: UIButton!
    
    fileprivate static let apiKey = "e787bf7419e4449e87a3dbdbdaae60cb"
    fileprivate static let rating = "g"
    fileprivate let queryTemplate = "http://api.giphy.com/v1/gifs/random?tag=%@&api_key=\(ViewController.apiKey)&rating=\(rating)"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    @IBAction func generateButtonTapped(_ sender: Any) {
        loadImageIntoImageView()
    }
    
    fileprivate func configView() {
        gifSearchTextField.delegate = self
    }

}


// MARK: - Misc Functions
extension ViewController{
    fileprivate func loadImageIntoImageView() {
        
        guard let validText = gifSearchTextField.text?.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "+"), !validText.isEmpty else{
            print("Invalid Search Text")
            return
        }
        
        gifSearchTextField.text = validText
        
        let queryString = String(format: queryTemplate, validText)
        
        guard let validURL = URL(string: queryString) else{
            print("Invalid URL")
            return
        }
        
        Alamofire.request(validURL, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
            .responseJSON(completionHandler: { (response) in
                print(response)
            })
            .responseObject { (response: DataResponse<GIFObject>) in
                if let validGifObject = response.result.value, let validURL = validGifObject.data?.image_url{
                    self.loadImageFromObject(gifURL: validURL)

                }else{
                    print("Error mapping object")
                }
        }
    }
    
    fileprivate func loadImageFromObject(gifURL: String){
        
        let gif = UIImage.gif(url: gifURL)
        self.gifImageView.image = gif
        
    }
}


// MARK: - UITextField Delegate
extension ViewController: UITextFieldDelegate{
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loadImageIntoImageView()
        return true
    }
    
}

