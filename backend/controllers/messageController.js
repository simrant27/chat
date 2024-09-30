// const Message = require("../models/Message");

// const Message = require("../models/messageModel"); // Make sure you import your Message model

// // Function to save message
// exports.saveMessage = async (msg) => {
//   try {
//     const message = new Message({
//       text: msg.text, // Use the correct field names
//       senderId: msg.senderId,
//       receiverId: msg.receiverId,
//     });

//     const savedMessage = await message.save(); // Save the message to MongoDB
//     return savedMessage;
//   } catch (error) {
//     console.error("Error saving message:", error);
//     throw error; // Rethrow the error to be handled by the caller
//   }
// };

// exports.fetchMessages = async (req, res) => {
//   const { senderId, receiverId } = req.query;
//   try {
//     const messages = await Message.find({
//       $or: [
//         { senderId, receiverId },
//         { senderId: receiverId, receiverId: senderId },
//       ],
//     }).sort({ timestamp: 1 });
//     res.status(200).json(messages);
//   } catch (error) {
//     res.status(500).json({ message: "Error fetching messages" });
//   }
// };
