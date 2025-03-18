const express = require("express");
const router = express.Router();
const {
      getMonitoringData
} = require("../services/monitoring");

// 🔹 Route untuk mengambil data sensor dengan parameter opsional sensorType
router.get("/:pondId/:sensorType?", async (req, res) => {
      try {
            const {
                  pondId,
                  sensorType
            } = req.params;
            console.log(`🔍 Mengambil data sensor untuk pondId: ${pondId}, sensorType: ${sensorType || "ALL"}`);

            // Ambil data berdasarkan sensorType (jika ada)
            const data = await getMonitoringData(pondId, sensorType);

            return res.status(200).json({
                  status: "success",
                  pondId,
                  sensorType: sensorType || "ALL",
                  sensor_data: data
            });
      } catch (error) {
            console.error(`❌ Error saat mengambil data sensor: ${error.message}`);
            return res.status(500).json({
                  status: "error",
                  message: error.message
            });
      }
});

module.exports = router;