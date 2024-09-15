const express = require("express");
var http = require("http");
// const cors = require("cors");
const { Socket } = require("socket.io");
const app = express(); //instance of express
const port = process.env.PORT || 5000; //port of local environment is detected
var server = http.createServer(app); //http server created
var io = require("socket.io")(server, {});

//middleware
app.use(express.json());
var clients = {};

io.on("connection", (socket) => {
  console.log("connected");
  console.log(socket.id, "has joined");
  socket.on("signin", (id) => {
    console.log(id);
    clients[id] = socket;
    console.log(clients);
  });

  socket.on("message", (msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    if (clients[targetId]) clients[targetId].emit("message", msg);
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server started");
});
