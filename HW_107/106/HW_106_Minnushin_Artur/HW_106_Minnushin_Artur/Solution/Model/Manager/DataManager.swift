import Foundation

protocol DataManagerProtocol {
    func syncSave(post: PostInfo)
    func asyncSave(post: PostInfo)
    func syncSaveLikedPost(indexPath: Int)
    func asyncSaveLikedPost(indexPath: Int)
    func syncGetAllPost() -> [PostInfo]
    func asyncGetAllPost() -> [PostInfo]
    func syncSearchByName(postName: String)
    func asyncSearchByName(postName: String)
    func syncSearchById(id: Int)
    func asyncSearchById(id: Int)
    func syncDelete(indexPath: Int)
    func asyncDelete(indexPath: Int)
    func syncDeleteLikePost(indexPath: Int)
    func asyncDeleteLikePost(indexPath: Int)
    func syncGetLikedPosts() -> [PostInfo]
}

class DataManager: DataManagerProtocol {
    var user: User?
    var posts: [PostInfo] = []
    var likedPost: [PostInfo] = []
    var filteredPost: [PostInfo] = []
    var postNewsLine: [PostInfo] = []
    let saveOperationLikedQueue = OperationQueue()
    let saveOpertionQueue = OperationQueue()
    let getOpertionQueue =  OperationQueue()
    let searchNameOpertionQueue = OperationQueue()
    let searchIdOpertionQueue = OperationQueue()
    let deleateOpertionQueue = OperationQueue()
    let deleteLikeOpertionQueue = OperationQueue()
    static let sigelton = DataManager()
    let users = UserDataBase.sigelton
    var isSearching = false
    func setupUser(user: User) {
        self.user = user
//        self.posts = user.posts
//        self.likedPost = user.likePosts
    }
    func syncSave(post: PostInfo) {
        posts.append(post)
    }
    func asyncSave(post: PostInfo) {
        let saveOpertion = BlockOperation {
            self.posts.append(post)
        }
        saveOpertion.completionBlock = {
            print("Операция добавления была выполнена")
        }
        saveOpertionQueue.addOperation(saveOpertion)
    }
    func syncSaveLikedPost(indexPath: Int) {
//        user?.posts[indexPath].isLiked = true
//        user?.posts[indexPath].counterLikes += 1
//        user?.likePosts.append(posts[indexPath])
    }
    func asyncSaveLikedPost(indexPath: Int) {
        let saveLikedPost = BlockOperation {
            self.posts[indexPath].isLiked = true
            self.posts[indexPath].counterLikes += 1
//            self.likedPost.append(self.user!.posts[indexPath])
        }
        saveLikedPost.completionBlock = {
            print("Отмеченый пост сохранен")
        }
        saveOperationLikedQueue.addOperation(saveLikedPost)
    }
    func syncGetAllPost() -> [PostInfo] {
//        return user!.posts
        return []
    }
    func syncGetAllFilteredPost() -> [PostInfo] {
        return filteredPost
    }
    func asyncGetAllPost() -> [PostInfo] {
        var result: [PostInfo] = []
        let getPostOpertion = BlockOperation {
            result = self.posts
        }
        getPostOpertion.completionBlock = {
            print("Посты успешно переданы")
        }
        getOpertionQueue.addOperation(getPostOpertion)
        return result
    }
    func syncSearchByName(postName: String) {
        filteredPost = posts.filter {$0.postComment.lowercased().contains(postName.lowercased())}
    }
    func asyncSearchByName(postName: String) {
        let searchByNameOpertion = BlockOperation {
            self.filteredPost = self.posts.filter {$0.postComment.lowercased().contains(postName.lowercased())}
        }
        searchByNameOpertion.completionBlock = {
            print("Поиск по имени выполнен успешно")
        }
        searchNameOpertionQueue.addOperation(searchByNameOpertion)
    }
    func syncSearchById(id: Int) {
        filteredPost = posts.filter {$0.postID == id}
    }
    func asyncSearchById(id: Int) {
        let searchByIdOpertion = BlockOperation {
            self.filteredPost = self.posts.filter {$0.postID == id}
        }
        searchByIdOpertion.completionBlock = {
            print("Поиск по ID успешно выполнен")
        }
        searchIdOpertionQueue.addOperation(searchByIdOpertion)
    }
    func syncDelete(indexPath: Int) {
//        self.user?.posts.remove(at: indexPath)
    }
    func asyncDelete(indexPath: Int) {
        let deleateOperation = BlockOperation {
//            self.user?.posts.remove(at: indexPath)
        }
        deleateOperation.completionBlock = {
            print("Пост успешно удален")
        }
        deleateOpertionQueue.addOperation(deleateOperation)
    }
    func syncDeleteLikePost(indexPath: Int) {
//        for index in 0...user!.likePosts.count - 1
//        where user?.posts[indexPath].postID == user!.likePosts[index].postID {
//            user!.posts[indexPath].isLiked = false
//            user!.posts[indexPath].counterLikes -= 1
//            user?.likePosts.remove(at: index)
//            break
//        }
    }
    func asyncDeleteLikePost(indexPath: Int) {
        let deleteLikePost = BlockOperation {
//            for index in 0...self.user!.likePosts.count - 1
//            where self.user?.posts[indexPath].postID == self.user!.likePosts[index].postID {
//                self.user!.posts[indexPath].isLiked = false
//                self.user!.posts[indexPath].counterLikes -= 1
//                self.user?.likePosts.remove(at: index)
//                break
//            }
        }
        deleteLikePost.completionBlock = {
            print("Добавленый пост удален")
        }
        deleteLikeOpertionQueue.addOperation(deleteLikePost)
    }
    func syncGetLikedPosts() -> [PostInfo] {
        return self.likedPost
    }
    func getUserByID(id: Int) -> User {
        var postUser: User = user!
//        for userItem in users.getData() where userItem.userId == id {
//            postUser = userItem
//            break
//        }
        return postUser
    }
    func getAllPostsFriends() {
        var postsFriend: [PostInfo] = []
        let users = UserDataBase.sigelton.getData()
        for user in users {
            postsFriend += user.posts
        }
        let lenght = postsFriend.count - 1
        for counterStep in 0..<lenght {
            for counterBubleSort in 0..<lenght - counterStep {
                if postsFriend[counterBubleSort].postDate.year <
                    postsFriend[counterBubleSort + 1].postDate.year ||
                    postsFriend[counterBubleSort].postDate.mounth >
                    postsFriend[counterBubleSort + 1].postDate.mounth &&
                    postsFriend[counterBubleSort].postDate.year ==
                    postsFriend[counterBubleSort + 1].postDate.year ||
                    postsFriend[counterBubleSort].postDate.day >
                    postsFriend[counterBubleSort + 1].postDate.day &&
                    postsFriend[counterBubleSort].postDate.mounth ==
                    postsFriend[counterBubleSort + 1].postDate.mounth &&
                    postsFriend[counterBubleSort].postDate.year ==
                    postsFriend[counterBubleSort + 1].postDate.year {
                    let temp = postsFriend[counterBubleSort]
                    postsFriend[counterBubleSort] = postsFriend[counterBubleSort + 1]
                    postsFriend[counterBubleSort + 1] = temp }
            }
        }
        postNewsLine = postsFriend
    }
    func deletePostsById(postId: Int, postUserid: Int) {
        for counter in 0..<posts.count-1 where posts[counter].postID == postId {
//            user!.posts.remove(at: counter)
            for counter1 in 0..<postNewsLine.count-1
            where postNewsLine[counter1].postID == postId &&
            postNewsLine[counter1].userPostId == postUserid {
                postNewsLine.remove(at: counter1)
                break
            }
            break
        }
    }
}
