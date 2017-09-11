//
//  ViewController.swift
//  Swift4_JSon-Part2
//  Youtube source: Lets build that app at https://youtu.be/YY3bTxgxWss  This is the second part from minute 15:09.
//  Source JSon file: "http://api.letsbuildthatapp.com/jsondecodable/website_description" (containing name- description-, courses-elements. NOT the ID-label)
//  Source JSon file: "http://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields" (containing missing elements)
//  Keep locs working on each url seperated. When using the one, comment the other. Default website_description-link is used
//  Created by Nietzsky on 05/09/2017.
//  Copyright © 2017 Testerik. All rights reserved.
//
import UIKit

struct WebsiteDescription: Decodable{
    let name: String
    let description: String
    let courses: [Course] //array of courses
}
struct Course: Decodable {
    let id: Int? //adding the ? makes the value optional. Also skipping the element when missing
    let name: String?
    let link: String?
    let imageUrl: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecodable/website_description"
        //on missing elements. e.g. only name available and other elements missing
        //let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: jsonUrlString) else {return} //
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //check response = status 200
            //print("Do thing")
            guard let data = data else {return}
//            let dataAsString = String(data:data, encoding: .utf8)
//            print(dataAsString as Any)
//
            do {
                //following locs do not work when elements are missing. Solution: Set the ?-optional in Struct
                //let courses = try
                //JSONDecoder().decode([Course].self, from: data)
                //print(courses)
                
                let websiteDescription =  try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.name, websiteDescription.courses, websiteDescription.description)
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name as Any)
                
                
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }

        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

