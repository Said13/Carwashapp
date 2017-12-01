iOS Client for Carwash App

Server-side of the App: https://github.com/Said13/Carwashapp-Server-side

Использованый сторонние библиотеки: Alamofire, ObjectMapper, GoogleMaps, ChameleonFramework

Сервер написан на фреймворке Vapor. REST Api. Сервер обменивается с клиентом json-ом. через get запросы

Клиент. Http запросы реализуются через библиотеку Alamofire. Полученный json трансформируется в объект класса через библиотеку ObjectMapper.

На первой вьюшке показывается объект с ближайшим местоположением. На второй вьюшке есть uitableview в котором показывается список объектов, сортированных по расстаянию до пользователя. Можно выбрать рядок из таблицы и будет показана подробная информация по выбранной автомойке. Цвета выбирались из библиотеки Chameleon.

Приложение еще не закончено.

![first screen](/screenshots/carwash.jpeg)
