// routes/messageRoutes.js
const express = require("express");
const Message = require("../models/Message");

const router = express.Router();

// You can define additional routes here for handling messages

// Example route for getting all messages (optional)
router.get("/", async (req, res) => {
  try {
    const { senderId, receiverId } = req.query;

    console.log("sender id", senderId);
    console.log("receiver id", receiverId);

    const messages = await Message.find({
      $or: [
        {
          senderId: senderId,
          receiverId: receiverId,
          senderId: receiverId,
          receiverId: senderId,
        },
      ],
    }).sort({ createdAt: -1 });

    console.log(messages)
    res.json(messages);
  } catch (error) {
    res.status(500).json({ error: "Failed to load messages" });
  }
});

router.post("/", async (req, res) => {
  console.log("i am calling");
  try {
    const body = req.body;
    const message = await Message.create(body);
    res.json(message);
  } catch (error) {
    res.status(500).json({ error: "Failed to load messages" });
  }
});

module.exports = router;
