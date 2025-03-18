const express = require("express");
const router = express.Router();
const {
      getDeviceConfig,
      updateDeviceConfig
} = require("../services/konfigurasi");

// 🔹 Endpoint GET untuk mengambil device_config berdasarkan pondId (bisa seluruh atau spesifik)
router.get("/:pondId/*?", async (req, res) => {
      try {
            const {
                  pondId
            } = req.params;
            const keyPath = req.params[0] || "";

            console.log(`📌 pondId: ${pondId}`);
            console.log(`📌 keyPath: ${keyPath}`);

            const data = await getDeviceConfig(pondId, keyPath);

            res.status(200).json({
                  status: "success",
                  pondId,
                  keyPath: keyPath || "all",
                  data: data
            });
      } catch (error) {
            res.status(500).json({
                  status: "error",
                  message: error.message
            });
      }
});

// 🔹 Endpoint PATCH untuk memperbarui bagian tertentu dari device_config
router.patch("/:pondId/*", async (req, res) => {
      try {
            const { pondId } = req.params;
            const keyPath = req.params[0]; // Menangkap path dinamis setelah pondId
            let newValue = req.body;

            // Jika body hanya berupa string angka ("34.0"), ubah ke Number
            if (typeof newValue === "string" && !isNaN(newValue)) {
                  newValue = Number(newValue);
            }

            if (newValue === undefined || newValue === null) {
                  return res.status(400).json({
                        status: "error",
                        message: "Data perubahan tidak boleh kosong"
                  });
            }

            const result = await updateDeviceConfig(pondId, keyPath, newValue);
            res.status(200).json({
                  status: "success",
                  message: result.message
            });
      } catch (error) {
            res.status(500).json({
                  status: "error",
                  message: error.message
            });
      }
});


module.exports = router;