Критерии оценки:

- Возможность расширения функционала(чтобы Ваш код возможно было улучшать, не сломав предыдущего функционала);
- Решение задания.

---
Инструкция к домашкам:

- Сделать Fork ветки к себе в репозиторий в новую ветку!;
- Выполнить основную задачу в xCode Project;
- Отправить Pull Request в эту ветку(HW106_ФИО);
- При сдаче задания после дедлайна, баллов будет много-меньше и проверяться оно будет больше 1 недели(также пересдать ее уже вряд ли будет можно);
- Пересдать код после получения комментария можно в течение N(уточнится позже) дней, при этом баллы не потеряются, возможность на ошибки у Вас имеется и поощряется.

**Задача 1: CatGram**
-
___

Вам прилетели новые задачи по проекту:

Реализовать авторизацию с менеджером(через протокол).
a) В менеджере хранятся пользователи
b) При вводе пароля для конкретного пользователя - открывается его страничка(сделать таких 3)
c) Вся работа в менеджере строится асинхронно используя Task и async-await
d) При авторизации открывается TabBar с лентой пользователя(ниже подробнее)

Реализовать менеджер для ленты
b) При вводе пароля для конкретного пользователя - открывается его страничка(сделать таких 3)
c) Вся работа в менеджере строится асинхронно используя Task и async-await

1. Каждая операция должна иметь асинхронную версию.
(прим: asyncSave(_ model: Model) ) 
2. Для каждой асинхронной операции (сохранение, получение, поиск, удаление) должны быть созданы свои OperationQueue и соотвественно вы используете нужную вам очередь добавляя туда те или иные действия и выполняя все асинхронно.
3. Сделать моковые кружочки историй(не жмякаются, но каруселить можно) - то есть collection View с круглыми секциями
4. Внутри ваш менеджер данных должен работать пока с  массивом(зашитым) данных ваших постов в инсте, т.е. в него вы сохраняете данные и из него вытаскиваете данные (при поиске модели), или возвращаете этот массив при запросе на все модели.   
5. Лента у всех может быть общей, то есть необязательно делать каждому пользователю свою ленту(но будет как доп задание)
6. Состав ленты пользователя на пост:
* Аватар, ник, кнопка 3 точки(если пост свой - можно удалить)
* Фото 
* Лайк, коммент, шаринг, избранное 
* Некая подпись добавленная вами.
* Дата поста. 
7. Удаление происходит асинхронно через ваш менеджер. После удаления как в таблице, так и в вашем профиле пост пропадает.

  ** ПРИМЕЧАНИЕ ** - TabBar содержит 2 рабочие вкладки: Лента и пользователь(можно увеличить по желанию)

___

**Дополнительная задача: Улучшение CatGram**

Требования:

1. Реализовать ленту для каждого пользователя
2. Реализовать систему, словно пользователи все в друзьях друг у друга и могут видеть НОВЫЕ посты пользователя(в ленте) (Проверить - чтобы пользователь не мог никак удалить пост другого пользователя)


