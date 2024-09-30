const fs = require("fs");
const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const mongoose = require("mongoose"); // Import mongoose
const cors = require("cors");

const app = express();
const port = 3000;

// Connect to MongoDB
mongoose
  .connect("mongodb://localhost:27017/chatApp", {
    // Update with your MongoDB URI
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("MongoDB connected successfully");
  })
  .catch((err) => {
    console.error("MongoDB connection error:", err);
  });

// Define Message Schema and Model
const messageSchema = new mongoose.Schema({
  text: String,
  senderId: String,
  receiverId: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

const Message = mongoose.model("Message", messageSchema);

const server = http.createServer(app);
const io = socketIo(server, {
  cors: { origin: "*" },
});

let clients = {};

// Middleware to load previous messages from MongoDB
const loadMessages = async () => {
  try {
    return await Message.find().sort({ createdAt: -1 }); // Fetch messages sorted by creation date
  } catch (error) {
    console.error("Error loading messages:", error);
    return []; // Return empty array in case of error
  }
};

// Load messages from the database when the app starts
loadMessages().then((messages) => {
  console.log("Loaded messages:", messages);
});

app.use(express.json());
app.use(cors());

io.on("connection", (socket) => {
  console.log("New client connected:", socket.id);

  socket.on("signin", (id) => {
    console.log(`${id} signed in.`);
    clients[id] = socket;
  });

  socket.on("message", async (msg) => {
    console.log("Message received: ", msg);

    // Save the message to the database
    const message = new Message(msg);
    await message.save();

    // Send message to the target user
    let targetId = msg.receiverId;
    if (clients[targetId]) {
      clients[targetId].emit("message", msg);
    }
  });

  socket.on("disconnect", () => {
    console.log("Client disconnected:", socket.id);
  });
});

server.listen(port, () => {
  console.log(`Server started on port ${port}`);
});
