# О приложении
ToDo List - iOS приложение для управления задачами, написанное на Swift с использование UIKit

Приложение построено по VIPER архитектуре

## CoreData
Для хранения данных используется Core Data. Данные хранятся в сущности ToDoEntity.

Представляются в UITableView с помощью NSFetchedResultsController.

## Предзагрузка
При первом запуске реализованная асинхронная загрузка и парсинг задач со стороннего источника.

Данные загружаются с https://drive.google.com/uc?export=download&id=1Q5kcuT_CrGNl_21Fbgz5lzLmrbr6al9u и парсятся в ToDoDTO для последующего сохранения в CoreData.

##  Интерфейс

### Задачи
<img width="294" height="640" alt="telegram-cloud-photo-size-2-5467482179878196130-y" src="https://github.com/user-attachments/assets/8a68628b-fe67-4479-af69-60446eff0d3f" /> 

### Контекстное меню
<img width="294" height="640" alt="telegram-cloud-photo-size-2-5467482179878196131-y" src="https://github.com/user-attachments/assets/e18a7775-a731-4432-b829-edb801b4c227" /> 

### Редактирование
<img width="294" height="640" alt="telegram-cloud-photo-size-2-5467482179878196133-y" src="https://github.com/user-attachments/assets/2b7ad1b5-7f32-4d00-9bb7-49b26a5da032" />


