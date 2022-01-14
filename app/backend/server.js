const express = require('express');
require('dotenv').config()
const cors = require('cors') 
const connectDB = require('./configurations/db-config')
const app = express();

app.use(express.json())
app.use(cors())
let port = process.env.PORT || 3000;
connectDB();



app.get('/', (req, res) => {
  res.send('Well Come to the API');
});

// const signup = require('./routes/signup')
// app.use('/signup' , signup)

const auth = require('./routes/auth_route')
app.use('/auth' , auth)

const homeRouter = require('./routes/home')
app.use('/home', homeRouter)

const serviceRouter = require('./routes/services')
app.use('/services', serviceRouter)

const categoryRouter = require('./routes/categories')
app.use('/categories', categoryRouter)

const reviewRouter = require('./routes/reviews')
app.use('/reviews', reviewRouter)

const searchRouter = require('./routes/search')
app.use('/search', searchRouter)

app.listen(port, () => {
  console.log(`Server is running on localhost:${port}`);
});