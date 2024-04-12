//
//  HistoryTableViewController.swift
//  Harit_Thoriya_FE_8953007
//
//  Created by thor on 2023-12-09.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    
    var historyFetch: [History]?
    
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(NewsHistoryTableViewCell.nib(), forCellReuseIdentifier: NewsHistoryTableViewCell.identifier)
        tableView.register(WeatherHistoryTableViewCell.nib(), forCellReuseIdentifier: WeatherHistoryTableViewCell.identifier)
        tableView.register(DirectionTableViewCell.nib(), forCellReuseIdentifier: DirectionTableViewCell.identifier)
       
       

        do{
            self.historyFetch = try content.fetch(History.fetchRequest())
            
            print("Number of history = \(String(self.historyFetch?.count ?? 0))")
        }
        catch{
            print("No Data")
        }
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyFetch?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let result = historyFetch?[indexPath.row].result {
            if result is News {
                let newCell = tableView.dequeueReusableCell(withIdentifier: "NewsHistoryTableViewCell", for: indexPath) as! NewsHistoryTableViewCell
                newCell.configure(history: historyFetch![indexPath.row])
             
                return newCell
            } else if result is Weather {
                let weatherCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHistoryTableViewCell", for: indexPath) as! WeatherHistoryTableViewCell
                self.tableView.register(WeatherHistoryTableViewCell.nib(), forCellReuseIdentifier: WeatherHistoryTableViewCell.identifier)
                weatherCell.configure(history: historyFetch![indexPath.row])
                
                return weatherCell
            } else if result is Direction {
                let directionCell = tableView.dequeueReusableCell(withIdentifier: "DirectionTableViewCell", for: indexPath) as! DirectionTableViewCell
                self.tableView.register(DirectionTableViewCell.nib(), forCellReuseIdentifier: DirectionTableViewCell.identifier)
                directionCell.configure(history: historyFetch![indexPath.row])
                
                return directionCell
            }
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHistoryTableViewCell", for: indexPath) as! NewsHistoryTableViewCell
        return cell
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1. Delete the row from the data source
            let deletedHistory = historyFetch?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            // 2. Delete the associated result (News, Weather, or Direction)
            if let result = deletedHistory?.result {
                content.delete(result)
            }
            
            // 3. Delete history object
            if let unwrappedHistory = deletedHistory {
                content.delete(unwrappedHistory)
            } else {
                // Handle the case where deletedHistory is nil
                print("Error: deletedHistory is nil")
            }

            // 4. Save the changes
            do {
                try content.save()
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }
    
    // Helper function to delete the result object
    private func delete(_ result: Result) {
        if let news = result as? News {
            deleteNews(news: news)
        } else if let weather = result as? Weather {
            deleteWeather(weather: weather)
        } else if let direction = result as? Direction {
            deleteDirection(direction: direction)
        }
    }

    private func deleteNews(news: News) {
        // Implement logic to delete News
        content.delete(news)
    }

    private func deleteWeather(weather: Weather) {
        // Implement logic to delete Weather
        content.delete(weather)
    }

    private func deleteDirection(direction: Direction) {
        // Implement logic to delete Direction
        content.delete(direction)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


