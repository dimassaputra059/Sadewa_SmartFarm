// models/kolam.js
const mongoose = require("mongoose");

const KolamSchema = new mongoose.Schema({
      idPond: {
            type: String,
            required: true,
            unique: true
      },
      namePond: {
            type: String,
            required: true
      },
      statusPond: {
            type: String,
            enum: ["Aktif", "Non-Aktif"],
            default: "Aktif"
      },
      createdAt: {
            type: Date,
            default: Date.now
      },
});

module.exports = mongoose.model("Kolam", KolamSchema);