//
//  ViewController.swift
//  XAMLParser
//
//  Created by Ramesh Ponnuvel on 01/11/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var ary_books = [Book]()
    var eName = String()
    var bookTitle = String()
    var bookAuthor = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml"){
            if let parse = XMLParser(contentsOf: path){
                parse.delegate = self
                //parse.parse()
                if !parse.parse(){
                    print("Data Errors Exist:")
                    let error = parse.parserError!
                    print("Error Description:\(error.localizedDescription)")
                    print("Line number: \(parse.lineNumber)")
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        print("didstartElement:- \(elementName)")
        if elementName == "book"{
            bookTitle = String()
            bookAuthor = String()
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("didendElement:- \(elementName)")

        if elementName == "book"{
            let book = Book()
            book.bookAuthor = bookAuthor
            book.bookTitle = bookTitle
            ary_books.append(book)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("foundcharacter:- \(string)")
        let data = string.trimmingCharacters(in: .whitespaces)
        if (!data.isEmpty){
            if eName == "title"{
                bookTitle += data
            }else if eName == "author"{
                bookAuthor +=  data
            }
        }

    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("error:- \(parseError.localizedDescription)")
    }
}


