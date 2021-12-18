const express = require('express');
const connectDB = require('./configurations/db-config')
const app = express();

app.use(express.json())

let port = process.env.PORT || 3000;

connectDB();

app.get('/', (req, res) => {
  res.send('Well Come to the API');
});

const signup = require('./routes/signup')
app.use('/signup' , signup)

app.listen(port, () => {
  console.log(`Server is running on localhost:${port}`);
});