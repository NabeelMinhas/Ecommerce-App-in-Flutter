# Flutter Cosmetics Shop Full explanation
## Introduction of App
This is a e-commerce type store which has a admin dashboard from which the admin can do all admin related activities. Firebase is use for database, authentication and storage services.
### Users and their roles
#### Admin

**Username And Password**

The admin has his own hardcodes username and password which is **nabeelshafiq223@gmail.com** and **Rajpoot** respectively (remember you can change the hardcoded username and password from lib/adminstration/login.dart file line number 96 and 97 and you have to give a username and password of your account which is present on firebase).

**Roles of Admin**

The Admin can do following things
Upload products.
Manage Orders which contain Four pages New_order, Proceed_order, Complete_order and Spam_order page. When Admin see new order then he can send the order to proceed section or to spam section if the order is not suitable. And then from proceed section he can send the order to complete section or to spam. From complete section he can delete the order because the service is alredy given to the user. If the admin send the order to spam by mistake then he can also recover the order.

#### Simple User
The user can see the app with or without login. 
He can login after registration.
The user can order products.

## File Structure of project
As we know we have main focus on **lib folder** so i will prefer to discuss the lib folder file structure here.
The lib folder further contain 3 folders
- admin_folder (contain add_product, new_order, etc pages)
- administrative_folder (contain login and registration.dart file) 
- pages_folder (which contain general pages like home_screen,product page etc)
- two open dart files also present in lib folder main file which is root of project and firebase initilization.dart file.
