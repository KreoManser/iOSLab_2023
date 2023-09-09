protocol MediaItem{
    var creator : String { get set }
    var conditionalContentUnit: Int { get set }
}

class Movie : MediaItem{

    var creator: String
    var conditionalContentUnit: Int
    var title: String
    var feedbacks : [Feedback] = []

    init(){
        creator = "Creator 1"
        conditionalContentUnit = 1
        title = "title 1"
    }

    init(creator: String, conditionalContentUnit : Int, title: String){
        self.creator = creator
        self.conditionalContentUnit = conditionalContentUnit
        self.title = title
    }

    func addNewFeedback(feedback: Feedback) -> Void {
        feedbacks.append(feedback)
        print("Feedback added: \(feedback.description)")
    }

    var description: String {
        var feedbackDescriptions = ""
        for feedback in feedbacks {
            feedbackDescriptions += feedback.description + "\n"
        }
        return "Сreator: \(creator), ConditionalContentUnit: \(conditionalContentUnit), Title: \(title)\nFeedbacks:\n\(feedbackDescriptions)"
    }
}


class Music: MediaItem{

    var creator: String
    var conditionalContentUnit: Int
    var title: String
    var feedbacks : [Feedback] = []


    init(){
        creator = "Creator 2"
        conditionalContentUnit = 2
        title = "title 2"
    }

    init(creator: String, conditionalContentUnit : Int, title : String){
        self.creator = creator
        self.conditionalContentUnit = conditionalContentUnit
        self.title = title
    }

    func addNewFeedback(feedback: Feedback) -> Void {
        feedbacks.append(feedback)
        print("Feedback added: \(feedback.description)")
    }

    var description: String {
        var feedbackDescriptions = ""
        for feedback in feedbacks {
            feedbackDescriptions += feedback.description + "\n"
        }
        return "Сreator: \(creator), ConditionalContentUnit: \(conditionalContentUnit), Title: \(title)\nFeedbacks:\n\(feedbackDescriptions)"
    }

}

class Book: MediaItem{

    var creator: String
    var conditionalContentUnit: Int
    var title : String
    var feedbacks : [Feedback] = []

    init(){
        creator = "Creator 3"
        conditionalContentUnit = 3
        title = "title 3"
    }
    init(creator: String, conditionalContentUnit : Int, title : String){
        self.creator = creator
        self.conditionalContentUnit = conditionalContentUnit
        self.title = title
    }

    func addNewFeedback(feedback: Feedback) -> Void {
        feedbacks.append(feedback)
        print("Feedback added: \(feedback.description)")
    }
    
    var description: String {
        var feedbackDescriptions = ""
        for feedback in feedbacks {
            feedbackDescriptions += feedback.description + "\n"
        }
        return "Сreator: \(creator), ConditionalContentUnit: \(conditionalContentUnit), Title: \(title)\nFeedbacks:\n\(feedbackDescriptions)"
    }
}


class Feedback{
    var estimation: Int = 1
    var feedbackDescription: String
    var titleFeedback: String

    init(estimation: Int, descriptionText: String, titleFeedback: String) {
        self.estimation = estimation
        self.feedbackDescription = descriptionText
        self.titleFeedback = titleFeedback
    }

    var description: String {
        return "Estimation: \(estimation), Title: \(titleFeedback), Description: \(feedbackDescription)"
    }
}


//MANAGER
class MediaManager{

    var arrayMedia = Array<Any>()
    init() {
        let movieDefault = Movie()
        let bookDefault = Book()
        let musicDefault = Music()
        arrayMedia.append(movieDefault)
        arrayMedia.append(bookDefault)
        arrayMedia.append(musicDefault)
    }
    // прежде чем получить объект с высшей оценкой нужно добавить отзывы на объекты
    func getHighestRatedWorks() -> [Any] {
        var sum : Int = 0
        var cnt : Int = 0
        var aboveAverage: [Any] = []
        for item in arrayMedia{
            if let itemBook = item as? Book{
                for feedback in itemBook.feedbacks{
                    sum += feedback.estimation
                    cnt += 1
                }
            }
        }
        for item in arrayMedia{
            if let itemMusic = item as? Music{
                for feedback in itemMusic.feedbacks{
                    sum += feedback.estimation
                    cnt+=1
                }
            }
        }
        for item in arrayMedia{
            if let itemMovie = item as? Movie{
                for feedback in itemMovie.feedbacks{
                    sum += feedback.estimation
                    cnt += 1
                }
            }
        }
        
        var averageValue: Double = Double(sum) / Double(cnt)
        
        for obj in arrayMedia{
            if let bookObj = obj as? Book{
                for feedback in bookObj.feedbacks{
                    if Double(feedback.estimation) > averageValue{
                        aboveAverage.append(bookObj)
                    }
                }
                
            }
            else if let movieObj = obj as? Movie{
                for feedback in movieObj.feedbacks{
                    if Double(feedback.estimation) > averageValue{
                        aboveAverage.append(movieObj)
                    }
                }
            }
            else if let musicObj = obj as? Music{
                for feedback in musicObj.feedbacks{
                    if Double(feedback.estimation) > averageValue{
                        aboveAverage.append(musicObj)
                    }
                }
            }
           
        }
        
        return aboveAverage
    }

    func addNewObject(element: Any) -> Void {
        arrayMedia.append(element)
    }


    func deleteObj(creatorDelete : String, titleDelete : String) -> Void {

        var filteredArray = arrayMedia.filter { item in
            if let mediaItem = item as? Book {
                return mediaItem.title != titleDelete && mediaItem.creator != creatorDelete
            }
            else if let mediaItem = item as? Music{
                return mediaItem.title != titleDelete && mediaItem.creator != creatorDelete
            }
            else if let mediaItem = item as? Movie{
                return mediaItem.title != titleDelete && mediaItem.creator != creatorDelete
            }
            return true
        }
        arrayMedia = filteredArray

    }

    func searchObj(creatorSearch: String, titleSearch : String) -> Any?{
        for item in arrayMedia{
            if let mediaItem = item as? Book {
                if mediaItem.title == titleSearch && mediaItem.creator == creatorSearch{
                    return mediaItem
                }
            }
            else if let mediaItem = item as? Music{
                if mediaItem.title == titleSearch && mediaItem.creator == creatorSearch{
                    return mediaItem
                }
            }
            else if let mediaItem = item as? Movie{
                if mediaItem.title == titleSearch && mediaItem.creator == creatorSearch{
                    return mediaItem
                }
            }
        }
        return nil

    }
}


//интерфейс для управления
let test1 = MediaManager()

var exit = true

while(exit){
    print("ENTER A NUMBER FROM ONE TO FIVE")
    print(###"1) Add new Movie\###n2) Add new Book\###n3) Add new Music\###n4) Deleting by the amount of content\###n5) Search by creator and name \###n6) Show the entire list\###n7) Add a review (to do this, enter the 1)title 2)creator 3)estimation 4)title 5)description)\###n8) Show works with the highest rating\###n9) Exit "###)

    if let command = readLine(), let integerValue = Int(command), (1...9).contains(integerValue) {
        switch integerValue {
        case 1 :
            print("enter the creator, title, and content unit in order")
            let creatorOptional = readLine()
            let contentUnitOptional = readLine()
            let titleOptional = readLine()
            if let creator = creatorOptional, let contentUnitString = contentUnitOptional, let title = titleOptional{
                if let contentUnitInt = Int(contentUnitString){
                    test1.addNewObject(element: Movie(creator: creator, conditionalContentUnit: contentUnitInt, title: title))
                }
            }
        case 2 :
            print("enter the creator, title, and content unit in order")
            let creatorOptional = readLine()
            let contentUnitOptional = readLine()
            let titleOptional = readLine()
            if let creator = creatorOptional, let contentUnitString = contentUnitOptional, let title = titleOptional{
                if let contentUnitInt = Int(contentUnitString){
                    test1.addNewObject(element: Book(creator: creator, conditionalContentUnit: contentUnitInt, title: title))
                }
            }

        case 3 :
            print("enter the creator, title, and content unit in order")
            let creatorOptional = readLine()
            let contentUnitOptional = readLine()
            let titleOptional = readLine()
            if let creator = creatorOptional, let contentUnitString = contentUnitOptional, let title = titleOptional{
                if let contentUnitInt = Int(contentUnitString){
                    test1.addNewObject(element: Music(creator: creator, conditionalContentUnit: contentUnitInt, title: title))
                }
            }
        case 4 :
            print("enter the title of the work and the creator to delete")
            let titleDelOpt = readLine()
            let creatorDelOpt = readLine()
            if let titleDel = titleDelOpt, let creatorDel = creatorDelOpt{
                test1.deleteObj(creatorDelete: creatorDel, titleDelete: titleDel)
            }

        case 5 :
            print("enter the title and creator in order to search for")
            let titleSearchOpt = readLine()
            let creatorSearchOpt = readLine()
            if let titleSrch = titleSearchOpt, let creatorSrch = creatorSearchOpt{
                let obj = test1.searchObj(creatorSearch: creatorSrch, titleSearch: titleSrch)
                if let bookObj = obj as? Book{
                    print(bookObj.description)
                }
                else if let movieObj = obj as? Movie{
                    print(movieObj.description)
                }
                else if let musicObj = obj as? Music{
                    print(musicObj.description)
                }
                else{
                    print("nothing")
                }
            }
        case 6 :
            for item in test1.arrayMedia {
                if let movieValue = item as? Movie {
                    print("\(movieValue.description)")
                } else if let bookValue = item as? Book {
                    print("\(bookValue.description)")
                } else if let musicValue = item as? Music {
                    print("\(musicValue.description)")
                }
            }
        case 7 :
            //какой то ужас со вложенностью (пробовал создать перед ифами экз. Feedback а потом в ифах инициализировать но чет не получалось и решил оставить так, подскажите что я могу сделать чтобы это выглядело лучше )
            let titleSearchOpt = readLine()
            let creatorSearchOpt = readLine()
            let estimationOpt = readLine()
            let titleFeedbackOpt = readLine()
            let descriptionOpt = readLine()
            if let estimationString = estimationOpt, let titleFeedback = titleFeedbackOpt, let description = descriptionOpt{
                if let estimationInt = Int(estimationString){
                    var newFeedback = Feedback(estimation: estimationInt, descriptionText: description, titleFeedback: titleFeedback)
                    if let titleSrch = titleSearchOpt, let creatorSrch = creatorSearchOpt{
                        let obj = test1.searchObj(creatorSearch: creatorSrch, titleSearch: titleSrch)
                        if let bookObj = obj as? Book{
                            bookObj.addNewFeedback(feedback: newFeedback)
                        }
                        else if let movieObj = obj as? Movie{
                            movieObj.addNewFeedback(feedback: newFeedback)
                        }
                        else if let musicObj = obj as? Music{
                            musicObj.addNewFeedback(feedback: newFeedback)
                        }
                    }
                }
            }
        case 8:
            var aboveAverge = test1.getHighestRatedWorks()
            for item in aboveAverge {
                if let movieValue = item as? Movie {
                    print("\(movieValue.description)")
                } else if let bookValue = item as? Book {
                    print("\(bookValue.description)")
                } else if let musicValue = item as? Music {
                    print("\(musicValue.description)")
                }
            }
        case 9:
            exit = false
        default :
            print("nice good")
        }

    }
    else{
        print("YOU ENTERED AN INCORRECT VALUE")
    }

}



