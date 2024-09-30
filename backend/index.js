const fs = require("fs");
const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const e = require("express");
const app = express();
const port = 3000;
const cors = require("cors");

var server = http.createServer(app);
var io = socketIo(server, {
  cors: { origin: "*" },
});

let messages = [];
var clients = {};

// Middleware to load previous messages from file
const loadMessages = () => {
  try {
    const data = fs.readFileSync("messages.json", "utf8");
    return JSON.parse(data);
  } catch (error) {
    return []; // Return empty array if the file doesn't exist or fails
  }
};

// Middleware to save messages to file
const saveMessages = (messages) => {
  fs.writeFileSync("messages.json", JSON.stringify(messages), "utf8");
};

// Load messages from the file when the app starts
messages = loadMessages();

app.use(express.json());
app.use(cors());

io.on("connection", (socket) => {
  console.log("connected");
  console.log("New client connected:", socket.id);

  socket.on("signin", (id) => {
    console.log(`${id} signed in.`);
    clients[id] = socket;
    // console.log(clients);
  });

  socket.on("message", (msg) => {
    console.log("Message received: ", msg);

    // Send message to the target user
    let targetId = msg.targetId;
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
