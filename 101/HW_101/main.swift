import Foundation

while true{
    print("выберите задачу для проверки: \n1 - основная задача, 2 - дополнительная задача с filter")
    let number = readLine()
    
    if(number == "1"){
        ui()
    }else if(number == "2"){
        filterFunctions()
    }
}

//Вот это все команды для консольного приложения(add, delete, search, evaluate, list sorted by rating, exit)
//я сделал интерфейс на английском потому что так аккуратнее выглядит, если нужно я переделаю
//еще когда делал в UI (func add) сильно нарушил принципы DRY, не понял как все сжать, надеюсь вы подскажите как сделать это так как нужно

