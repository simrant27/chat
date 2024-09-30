// app.js
const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
// const mongoose = require("mongoose");
const cors = require("cors");
// const config = require("./config/db");
const connectDB = require("./config/db");

const { initSocket } = require("./services/socket_sevice");
const messageRoutes = require("./routes/messageRoute"); // Import routes

const app = express();
const server = http.createServer(app);
const io = socketIo(server, { cors: { origin: "*" } });

connectDB();

app.use(express.json());
app.use(cors());

// Connect to MongoDB
// mongoose
//   .connect(config.mongoURI)
//   .then(() => {
//     console.log("MongoDB connected successfully");
//   })
//   .catch((err) => {
//     console.error("MongoDB connection error:", err);
//   });

// Initialize socket connections
initSocket(io);

// Use message routes
app.use("/api/messages", messageRoutes); // Define base route for messages

// Start the server
server.listen(5000, () => {
  console.log(`Server started on port 5000`);
});
