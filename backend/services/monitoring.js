const {
      db
} = require("../config/firebaseConfig");

// 🔹 Fungsi untuk mengambil data sensor dari Firebase
const getMonitoringData = async (pondId, sensorType = null) => {
      try {
            let firebasePath = `Sadewa_SmartFarm/ponds/${pondId}/sensor_data`;

            // Jika sensorType diberikan, ambil data spesifik
            if (sensorType) {
                  firebasePath += `/${sensorType.toLowerCase()}`;
            }

            console.log(`📡 Mengakses Firebase path: ${firebasePath}`);
            const snapshot = await db.ref(firebasePath).once("value");

            // Jika tidak ada data
            if (!snapshot.exists()) {
                  throw new Error(`Data sensor ${sensorType || "ALL"} untuk pondId ${pondId} tidak ditemukan.`);
            }

            console.log(`✅ Data sensor ditemukan untuk pondId ${pondId}, sensorType: ${sensorType || "ALL"}`);
            return snapshot.val();
      } catch (error) {
            console.error(`❌ Gagal mengambil data sensor: ${error.message}`);
            throw new Error(`Gagal mengambil data sensor: ${error.message}`);
      }
};

module.exports = {
      getMonitoringData
};