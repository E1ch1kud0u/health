//
//  ResultViewController.swift
//  HealthKitEdition
//
//  Created by Airi Furukawa on 2022/11/11.
//

import UIKit
import SafariServices

class ResultViewController: UIViewController, UITableViewDataSource, SFSafariViewControllerDelegate, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCells", for: indexPath)
        cell.textLabel?.text = InfoList[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        if let imageData = try? Data(contentsOf: InfoList[indexPath.row].urlToImage) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heighForRowAt indexPath: IndexPath) ->CGFloat {
        return 100
    }

    @IBOutlet weak var tableView: UITableView!
    var InfoList: [(title: String, url: URL, urlToImage: URL)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let words = UserDefaults.standard.string(forKey: "WantedInformation") {
          SearchInfo(keyword: words)
        }
    }
    
    func SearchInfo(keyword: String) {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let req_url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword_encode)&apiKey=3cdc24314708452e96caf1adfb49b6fc") else {
            return
        }
        
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session as URLSession.dataTask;(with: req, completionHandler: { (data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                if let articles = json.articles{
                    self.InfoList.removeAll()
                    
                    for article in articles {
                        if let title = article.title, let url = article.url, let urlToImage = article.urlToImage {
                            let Info = (title, url, urlToImage)
                            self.InfoList.append(Info)
                        }
                    }
                    self.tableView.reloadData()
                    
                    if let Infodbg = self.InfoList.first {
                        print("--------------------")
                        print("InfoList[0] = \(Infodbg)")
                    }
                }
            } catch {
                print("Error detected")
            }
        })
        task.resume()
    }
    
    struct ArticleJson: Codable {
        let title: String?
        let url: URL?
        let urlToImage: URL?
    }
    struct ResultJson: Codable {
        let article: [ArticleJson]?
    }
}
