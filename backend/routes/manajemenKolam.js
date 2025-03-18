// routes/manajemenKolam.js
const express = require("express");
const Kolam = require("../models/kolam");
const {
      verifyToken,
      isAdmin
} = require("../middleware/auth");
const kolamService = require("../services/manajemenKolam");

const router = express.Router();

// ✅ Ambil semua kolam
router.get("/kolam", verifyToken, async (req, res) => {
      const response = await kolamService.getAllKolam();
      res.status(response.status).json(response);
});

// ✅ Tambah kolam baru
router.post("/kolam", verifyToken, isAdmin, async (req, res) => {
      const {
            idPond,
            namePond
      } = req.body;
      const response = await kolamService.createKolam({
            idPond,
            namePond,
            statusPond: "Aktif"
      });
      res.status(response.status).json(response);
});

// ✅ Perbaikan di backend (router.js)
router.put("/kolam/:id", verifyToken, isAdmin, async (req, res) => {
      const {
            pond_id,
            name,
            status
      } = req.body;
      try {
            const updatedKolam = await kolamService.updateKolam(req.params.id, {
                  pond_id,
                  namePond: name, // ✅ Sesuaikan dengan struktur database
                  statusPond: status
            });
            if (!updatedKolam) {
                  return res.status(404).json({
                        message: "Kolam tidak ditemukan"
                  });
            }
            res.status(200).json({
                  id: updatedKolam.id,
                  idPond: updatedKolam.pond_id,
                  namePond: updatedKolam.namePond,
                  statusPond: updatedKolam.statusPond
            });
      } catch (error) {
            console.error("❌ Error updating kolam:", error);
            res.status(500).json({
                  message: "Terjadi kesalahan server"
            });
      }
});

// ✅ Hapus kolam
router.delete("/kolam/:id", verifyToken, isAdmin, async (req, res) => {
      const response = await kolamService.deleteKolam(req.params.id);
      res.status(response.status).json(response);
});

module.exports = router;