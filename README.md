# Notes App

## Languages and Tools
### Frontend (Flutter)
##### Clone the repository.
##### Navigate to the frontend directory.
##### Run 'flutter pub get' to install dependencies.
##### Use Flutter CLI commands to run the app on your preferred device/emulator.

### Backend (Node.js + MongoDB)
##### Clone the repository.
##### Navigate to the backend directory.
##### Run npm install to install dependencies.
##### Set up MongoDB and configure the connection string in a .env file.
##### Run npm start to start the Node.js server.


## Features
## 1- Add Note

#### Endpoint
- `/api/notes/`

#### Method
- `POST`

#### Description
Adds a new note with a name, content, and color representation.

#### Request Payload
```json
{
  "name": "Note Name",
  "content": "Note Content",
  "color": "green" // Color in hexadecimal format
}
```

## 2- Delete Note
#### Endpoint
- `/api/notes/:noteId`

#### Method
- `DELETE`

#### Description
Deletes the specified note by its unique identifier.

#### Request Parameters
- `noteId`: The unique identifier of the note to be deleted.

## 3- Update Note

#### Endpoint
- `/api/notes/:noteId`

#### Method
- `PATCH`

#### Description
Updates an existing note with new content, name, or color.

#### Request Parameters
- `noteId`: The unique identifier of the note to be updated.

#### Request Payload
```json
{
  "name": "Updated Note Name",
  "content": "Updated Note Content",
  "color": "red" // Updated color in hexadecimal format
}
```







