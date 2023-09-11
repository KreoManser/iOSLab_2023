import Foundation

class Manager{
    
    public var listItems: Array<MultiMediaItem> = []
    public var listSortRatingItems: Array<MultiMediaItem> = []
    
    func add(item: MultiMediaItem){
        listItems.append(item)
    }
    
    func delete(name: String){
        let item = search(name: name)
        listItems.remove(at: item!.0)
    }
    
    func search(name: String) -> (Int, MultiMediaItem)?{
        for i in 0 ... listItems.count{
            if listItems[i].name == name{
                return (i,listItems[i])
            }
        }
        return nil
    }
    
    func evaluate(name: String, rating: Int){
        let index = search(name: name)?.0
        listItems[index!].rating = rating
    }
    
    func sortRating(){
        listSortRatingItems = listItems.sorted { $0.rating > $1.rating }
    }
}

struct MultiMediaItem{
    var name: String
    var rating: Int
    var item: Types
}
