// models/Message.js
const mongoose = require("mongoose");

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

module.exports = Message;
