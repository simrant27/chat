// services/socketService.js
const Message = require("../models/Message");

let clients = {};

const initSocket = (io) => {
  console.log("on socket")
  io.on("connection", (socket) => {
    console.log("New client connected:", socket.id);

    socket.on("signin", (id) => {
      console.log(`${id} signed in.`);
      if (clients[id]) {
        clients[id].disconnect();
      }

      clients[id] = socket;
    });

    socket.on("message", async (msg) => {
      console.log("Message received: ", msg);

      const message = new Message({
        text: msg.message,
        senderId: msg.sourceId,
        receiverId: msg.targetId,
      });

      await message.save();

      let targetId = msg.targetId;
      if (clients[targetId]) {
        clients[targetId].emit("message", {
          message: msg.message,
          sourceId: msg.sourceId,
          targetId: msg.targetId,
        });
      }
    });

    socket.on("disconnect", (reason) => {
      console.log("Client disconnected:", socket.id);
      for (const id in clients) {
        if (clients[id] === socket) {
          delete clients[id];
          console.log(`Removed client ${id} from clients.`);
          break;
        }
      }
    });
  });
};

module.exports = { initSocket };
