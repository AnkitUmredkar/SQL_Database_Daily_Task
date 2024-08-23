 # sqflite package

- The sqflite package is a Flutter plugin for performing SQLite database operations within apps. It enables local data storage on the device, making it ideal for apps that need to manage structured data like user preferences or lists. SQLite is lightweight and disk-based, requiring no separate server process, and allows data access using SQL queries.

## Features

#### Local Data Storage :
- Provides a way to store data locally on the device, ensuring that data is available even when the app is offline.

#### SQL Query Support :
- Enables the use of SQL commands like SELECT, INSERT, UPDATE, and DELETE for interacting with the database.

#### CRUD Operations :
- Facilitates the creation, reading, updating, and deletion of records in the database.

#### Efficient Data Management :
- Ideal for apps that require complex queries, large datasets, or need to perform operations on structured data.

## Database Table
<img src="https://github.com/user-attachments/assets/5506d1cf-3134-40e2-92f7-fed7806524dc"/>

<h1 align="left"> </h1>

<h1 align="center">🔶 18.2 CRUD Operation in Budget Tracker App 🔶</h1>

- This Flutter application implements a CRUD (Create, Read, Update, Delete) functionality for managing Budget's Expense and Income using the GetX state management package and SQL Database.

1. **Create** : Add new Record like category and amount using addRecord method which is stored in Controller. This Details Add to a dataList and it is managed by a GetX controller..

2. **Read** : Display the list of expense or income by observing the dataList list with `Obx` or `GetBuilder` in the UI. The list is stored in the Controller class.

3. **Update** : Modify an Budget's details by tap on budget item.it will be open dialog box where you can updaterecord

4. **Delete** : Remove an budget record from dataList through a deleteRecord method which is store in Controller.

### Tech Stack
- **get** : This package use for efficient state management
- **sqflite** : This package use for store budget data in database

<h1 align="left"> </h1>

<div align="center">
  <img height="550" align="left" src="https://github.com/user-attachments/assets/a298e717-13a8-4a3c-abed-5400f33e01c5"/>
  <img height="550" src="https://github.com/user-attachments/assets/299a77fc-e165-452b-a68f-af741cd3c6d3"/>
  <img height="550"  align="right" src="https://github.com/user-attachments/assets/05b648f1-ce6c-4f9c-8e49-e7fc137b34b7"/>
</div>

<h1 align="left"> </h1>

<div align="center">
<img height="550" src="https://github.com/user-attachments/assets/a9cf220a-10d0-493d-9f7b-3fbba2dd9341"/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img height="550" src="https://github.com/user-attachments/assets/466b9a69-f1c4-4954-81fd-b91d04856208"/>
</div>

<h1 align="left"> </h1>

<div align="center">
<video height="550" src="https://github.com/user-attachments/assets/aeb0cacc-1b46-4c8e-9b9c-7c42d54b0333"/>
</div>


