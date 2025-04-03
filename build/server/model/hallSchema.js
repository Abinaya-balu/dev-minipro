const mongoose = require('mongoose');

const hallSchema = new mongoose.Schema({
  name: {  // Slot Title
    type: String,
    required: true,
    unique: true,
  },
  capacity: {  // Available Slots
    type: Number,
    required: true,
  },  
  amenities: {  // Included Services
    type: String,
    required: true,
  },  
  description: {  // Operating Hours
    type: String,
    required: true,
  },
  price: {  // Price Per Slot
    type: Number,
    required: true,
  },
  hallCreater: {  // Creator's Email
    type: String,
    required: true,
  },
});

const Hall = mongoose.model('Hall', hallSchema);

module.exports = Hall;
