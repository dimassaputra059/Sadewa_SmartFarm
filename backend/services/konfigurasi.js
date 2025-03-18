const {
      db
} = require("../config/firebaseConfig");

// 🔹 Fungsi untuk mendapatkan device_config berdasarkan pondId & keyPath
const getDeviceConfig = async (pondId, keyPath = "") => {
      try {
            // Perbaiki format path agar tidak ada "/" yang salah
            let fullPath = `Sadewa_SmartFarm/ponds/${pondId}/device_config`;
            if (keyPath) {
                  fullPath += `/${keyPath.replace(/^\/*|\/*$/g, '')}`;
            }


            // Ambil data dari Firebase
            const snapshot = await db.ref().child(fullPath).once("value");

            // Jika data tidak ditemukan
            if (!snapshot.exists()) {
                  throw new Error(`Data tidak ditemukan di path: ${fullPath}`);
            }

            return snapshot.val();
      } catch (error) {
            throw new Error(`Gagal mengambil data: ${error.message}`);
      }
};

// 🔹 Fungsi untuk memperbarui device_config tanpa menghapus data lain
const updateDeviceConfig = async (pondId, keyPath, newValue) => {
      try {
            if (!keyPath) {
                  throw new Error("Path konfigurasi harus ditentukan.");
            }

            // Pastikan path tidak ada "/" berlebih
            let updatePath = `Sadewa_SmartFarm/ponds/${pondId}/device_config/${keyPath.replace(/^\/|\/$/g, '')}`;

            // Pastikan hanya angka atau objek yang masuk ke Firebase
            if (typeof newValue === 'number' || typeof newValue === 'string') {
                  newValue = Number(newValue); // Pastikan dikonversi ke angka
                  await db.ref().child(updatePath).set(newValue);
            } else if (typeof newValue === 'object' && newValue !== null) {
                  await db.ref().child(updatePath).update(newValue);
            } else {
                  throw new Error("Format data tidak valid.");
            }

            return {
                  message: `Berhasil memperbarui ${keyPath}`
            };
      } catch (error) {
            throw new Error(`Gagal memperbarui data: ${error.message}`);
      }
};

module.exports = {
      getDeviceConfig,
      updateDeviceConfig
};