//
//  NewsViewController.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//



import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTable: UITableView!
    @IBOutlet weak var myTabBar: UITabBar!
    
    var newsData: NewsModel?
    var history: History?
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTabBar.delegate = self
        newsTable.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTable.delegate = self
        newsTable.dataSource = self
        
        navigationBarSetup()
        
        
        loadNewsDataFromHome()
    }
    
    // Navigation Bar Setup
    fileprivate func navigationBarSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(homeButtonTapped))
        navigationItem.title = "Local News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
    }
    
    // Logic for clicking home button
    @objc func homeButtonTapped() {
        // Navigate to home page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "Home") as? MainViewController {
            navigationController?.setViewControllers([homeViewController], animated: true)
        }
    }
    
    // showing alert box for searching news
    @objc func addButtonTapped() {
        
        let alertController = UIAlertController(title: "Where would you like to go?", message: nil, preferredStyle: .alert)
        
        //Alert textfield
        var destinationTextField: UITextField?
        alertController.addTextField { textField in
            textField.placeholder = "Destination"
            destinationTextField = textField
        }
        
        //Alert action button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let goAction = UIAlertAction(title: "Go", style: .default) { _ in
            if let destination = destinationTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self.findingNews(destination)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(goAction)
        present(alertController, animated: true)
    }
    
    // getting news data sent by home page
    func loadNewsDataFromHome() {
        if let history = history {
            findingNews(history.searchName!)
        } else {
            print("History is nil")
        }
    }
    
    // Saving news history to core data
    private func saveNewsHistory(history: History?, destination: String?) {
        guard let history = history else {
            self.history = History(context: content)
            self.history?.historyId = UUID()
            self.history?.dateTime = Date()
            self.history?.searchName = destination
            self.history?.originSource = "News"
            return
        }
        
        let news = News(context: self.content)
        
        if let article = self.newsData?.articles?[0] {
            news.resultId = UUID()
            news.title = article.title
            news.discription = article.description
            news.source = article.source?.name
            news.author = article.author
        } else {
            print("Article empty")
        }
        
        self.history?.result = news
        do {
            try self.content.save()
            print("Save Successfully")
        } catch {
            print("Error saving data")
        }
    }
    
    // News API calling for given destination
    fileprivate func findingNews(_ destination: String) {
        let urlString = "https://newsapi.org/v2/everything?q=\(destination)&apiKey=ab286084d03345eb88eb9976c7cb7597"
        
        print("Destination URL: \(urlString)")
        
        let urlSession = URLSession(configuration: .default)
        
        if let url = URL(string: urlString) {
            let dataTask = urlSession.dataTask(with: url) { (data, _, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        self.newsData = try jsonDecoder.decode(NewsModel.self, from: data)
                        DispatchQueue.main.async {
                            self.newsTable.reloadData()
                        }
                        self.saveNewsHistory(history: self.history, destination: destination)
                    } catch let decodingError {
                        print("Error decoding JSON: \(decodingError)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}

extension NewsViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        CommonTabBarHandler.tabSelection(for: item, navigationController: navigationController)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData?.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell

        if let article = newsData?.articles?[indexPath.row] {
            cell.configure(
                title: article.title,
                description: "\(article.description ?? "No Data Found")",
                source: "Source: \(article.source?.name ?? "No Data Found")",
                author: "Author: \(article.author ?? "No Data Found")"
            )
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
