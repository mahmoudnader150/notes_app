/* eslint-disable prettier/prettier */
/* eslint-disable import/newline-after-import */
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const app = require('./app');

dotenv.config({ path: './config.env' });
console.log(process.env);

const DB = process.env.DATABASE.replace('<PASSWORD>', process.env.DATABASE_PASSWORD);

mongoose
  .connect(DB, {
    useNewUrlParser: true,
    useUnifiedTopology: true, 
   // useUnifiedTopology: true, // Adding the unified topology option
  })
  .then((con) => {
    console.log(con.connections);
    console.log('DB connection successful');
  })
  .catch((err) => {
    console.error('Error connecting to the database:', err);
  });



 

const port = process.env.PORT  ||  8000;
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});

 