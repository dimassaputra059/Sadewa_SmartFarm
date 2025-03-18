const express = require("express");
const router = express.Router();
const notificationService = require("../services/notifikasi"); // ✅ Perbaikan path
const {
      verifyToken
} = require("../middleware/auth");

// 🔹 API: Ambil Notifikasi Berdasarkan ID (GET)
router.get("/:id", verifyToken, async (req, res) => { // ✅ Tambahkan autentikasi
      try {
            const notification = await notificationService.getNotificationById(req.params.id);
            if (!notification) {
                  return res.status(404).json({
                        error: "Notifikasi tidak ditemukan"
                  });
            }
            res.status(200).json(notification);
      } catch (error) {
            console.error("❌ Error saat mengambil notifikasi:", error);
            res.status(500).json({
                  error: "Gagal mengambil notifikasi",
                  details: error.message
            });
      }
});

// 🔹 API: Ambil Notifikasi Berdasarkan idPond (GET)
router.get("/pond/:idPond", verifyToken, async (req, res) => {
      try {
            const notifications = await notificationService.getNotificationsByPondId(req.params.idPond);
            if (!notifications || notifications.length === 0) {
                  return res.status(404).json({
                        error: "Tidak ada notifikasi untuk kolam ini"
                  });
            }
            res.status(200).json(notifications);
      } catch (error) {
            console.error("❌ Error saat mengambil notifikasi berdasarkan idPond:", error);
            res.status(500).json({
                  error: "Gagal mengambil notifikasi",
                  details: error.message
            });
      }
});


// 🔹 API: Tandai Notifikasi sebagai "Read" (PATCH)
router.patch("/:id/read", verifyToken, async (req, res) => { // ✅ Tambahkan autentikasi
      try {
            const updatedNotification = await notificationService.markNotificationAsRead(req.params.id);
            if (!updatedNotification) {
                  return res.status(404).json({
                        error: "Notifikasi tidak ditemukan"
                  });
            }
            res.status(200).json({
                  message: "✅ Notifikasi ditandai sebagai dibaca",
                  notification: updatedNotification
            });
      } catch (error) {
            console.error("❌ Error saat memperbarui notifikasi:", error);
            res.status(500).json({
                  error: "Gagal memperbarui notifikasi",
                  details: error.message
            });
      }
});

/*// 🔹 API: Hapus Notifikasi Lama (DELETE)
router.delete("/old", verifyToken, async (req, res) => { // ✅ Tambahkan autentikasi
      try {
            await notificationService.deleteOldNotifications();
            res.status(200).json({
                  message: "🗑️ Notifikasi lama berhasil dihapus!"
            });
      } catch (error) {
            console.error("❌ Error saat menghapus notifikasi lama:", error);
            res.status(500).json({
                  error: "Gagal menghapus notifikasi lama",
                  details: error.message
            });
      }
});
*/

module.exports = router;