const mongoose = require("mongoose");

const historySchema = new mongoose.Schema({
      idPond: {
            type: String,
            required: true
      },
      date: {
            type: String,
            required: true
      },
      data: [{
            time: String,
            temperature: Number,
            pH: Number,
            salinity: Number,
            turbidity: Number,
            rain_status: Boolean,
      }, ],
      created_at: {
            type: Date,
            default: Date.now
      },
});

const History = mongoose.model("History", historySchema);
module.exports = History;