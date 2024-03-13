//
//  ViewController.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 10.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let session = URLSession.shared
    var articles: [Article] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.identifierSegue,
              let detailVC = segue.destination as? DetailedInformationViewController
        else { return }
        
        detailVC.article = sender as? Article
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifierCell, for: indexPath)
        let article = articles[indexPath.row]
        
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = articles[indexPath.row]
        performSegue(withIdentifier: Constants.identifierSegue, sender: info)
    }
}

// MARK: - Network

extension ViewController {
    private func fetchData() {
        guard let url = URL(string: Constants.url) else { return }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    
                    self.articles = result.results
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                
            } catch let error {
                print(String(describing: error))
            }
        }.resume()
    }
}

private enum Constants {
    static let identifierCell = "identifier"
    static let url = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=bae8JDzv69KTGEbzAOG2xLnjAlmsWMoY"
    static let identifierSegue = "detailedInformation"
}
