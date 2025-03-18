const {
      db
} = require("../config/firebaseConfig");
const {
      createNotification
} = require("./notifikasi");
const Kolam = require("../models/kolam");
const Notification = require("../models/notifikasi"); // Import model notifikasi

// 🔹 Fungsi untuk mencegah notifikasi duplikat dalam 5 menit terakhir
const isDuplicateNotification = async (idPond, type) => {
      const fiveMinutesAgo = new Date();
      fiveMinutesAgo.setMinutes(fiveMinutesAgo.getMinutes() - 5);

      const existingNotification = await Notification.findOne({
            idPond,
            type,
            created_at: {
                  $gte: fiveMinutesAgo
            }
      });

      return !!existingNotification; // Kembalikan true jika ada notifikasi serupa dalam 5 menit terakhir
};

const previousValues = {};

// 🔹 Fungsi untuk mengambil nilai awal dari Firebase
const initializePreviousValues = async () => {
      const pondsRef = db.ref("Sadewa_SmartFarm/ponds");
      const pondsSnapshot = await pondsRef.once("value");
      const pondsData = pondsSnapshot.val();

      if (pondsData) {
            Object.keys(pondsData).forEach((pondId) => {
                  const pondData = pondsData[pondId];

                  previousValues[pondId] = {
                        thresholds: pondData.device_config ?.thresholds || null,
                        feeding_schedule: pondData.device_config ?.feeding_schedule ?.schedule || null,
                        aerator_delay: pondData.device_config ?.aerator ?.aerator_delay || null,
                  };
            });
      }

      console.log("✅ Previous values initialized from Firebase.");
};

// 🔹 Panggil fungsi inisialisasi saat aplikasi dijalankan
initializePreviousValues();

// 🔹 Pemantauan Firebase Realtime Database
db.ref("Sadewa_SmartFarm/ponds").on("child_changed", async (snapshot) => {
      const pondId = snapshot.key;
      const pondData = snapshot.val();
      if (!pondData) return;

      // 🔹 Ambil namePond dari MongoDB
      const kolam = await Kolam.findOne({
            idPond: pondId
      });
      const namePond = kolam ? kolam.namePond : pondId; // Jika tidak ditemukan, gunakan pondId

      console.log(`📡 Data Changed for ${namePond} (Pond ID: ${pondId})`);

      // 🔹 Notifikasi Isi Pakan (feed_alert)
      if (pondData.isi_pakan === false && !(await isDuplicateNotification(pondId, "feed_alert"))) {
            console.log(`📢 Feed alert triggered for ${namePond}`);

            await createNotification({
                  idPond: pondId,
                  type: "feed_alert",
                  title: "Pakan Telah Diisi",
                  message: `Pakan telah diisi pada kolam ${namePond}`,
                  time: new Date(),
                  status: "unread",
                  metadata: {
                        isi_pakan: true
                  }
            });
      }

      // 🔹 Notifikasi Kualitas Air (water_quality_alert)
      if (pondData.sensor_data && pondData.device_config) {
            const {
                  ph,
                  salinity,
                  temperature,
                  turbidity
            } = pondData.sensor_data;
            const {
                  thresholds
            } = pondData.device_config;

            const alerts = [];
            if (ph < thresholds.ph.low || ph > thresholds.ph.high) alerts.push("pH");
            if (salinity < thresholds.salinity.low || salinity > thresholds.salinity.high) alerts.push("Salinitas");
            if (temperature < thresholds.temperature.low || temperature > thresholds.temperature.high) alerts.push("Suhu");
            if (turbidity < thresholds.turbidity.low || turbidity > thresholds.turbidity.high) alerts.push("Kekeruhan");

            if (alerts.length > 0 && !(await isDuplicateNotification(pondId, "water_quality_alert"))) {
                  console.log(`🚨 Water quality alert for ${namePond}: ${alerts.join(", ")}`);

                  await createNotification({
                        idPond: pondId,
                        type: "water_quality_alert",
                        title: "Peringatan Kualitas Air",
                        message: `Parameter berikut di luar batas normal: ${alerts.join(", ")} di kolam ${namePond}`,
                        time: new Date(),
                        status: "unread",
                        metadata: {
                              alerts
                        },
                  });
            }
      }

      // 🔹 Notifikasi Perubahan Ambang Batas Sensor (threshold_update)
      if (pondData.device_config && pondData.device_config.thresholds) {
            const newThresholds = pondData.device_config.thresholds;
            const prevThresholds = previousValues[pondId].thresholds;

            if (prevThresholds && JSON.stringify(prevThresholds) !== JSON.stringify(newThresholds)) {
                  if (!(await isDuplicateNotification(pondId, "threshold_update"))) {
                        console.log(`🔧 Threshold updated for ${namePond}`);

                        await createNotification({
                              idPond: pondId,
                              type: "threshold_update",
                              title: "Perubahan Ambang Batas Sensor",
                              message: `Ambang batas sensor untuk kolam ${namePond} telah diperbarui`,
                              time: new Date(),
                              status: "unread",
                              updated_by: "System",
                              metadata: {
                                    previous_thresholds: prevThresholds,
                                    new_thresholds: newThresholds
                              },
                        });
                  }
            }

            // Perbarui nilai sebelumnya
            previousValues[pondId].thresholds = newThresholds;
      }

      // 🔹 Notifikasi Perubahan Jadwal Pakan (feed_schedule_update)
      if (pondData.device_config && pondData.device_config.feeding_schedule) {
            const newSchedule = pondData.device_config.feeding_schedule.schedule;
            const prevSchedule = previousValues[pondId].feeding_schedule;

            if (prevSchedule && JSON.stringify(prevSchedule) !== JSON.stringify(newSchedule)) {
                  if (!(await isDuplicateNotification(pondId, "feed_schedule_update"))) {
                        console.log(`📅 Feeding schedule updated for ${namePond}`);

                        await createNotification({
                              idPond: pondId,
                              type: "feed_schedule_update",
                              title: "Jadwal Pakan Diperbarui",
                              message: `Jadwal pemberian pakan untuk kolam ${namePond} telah diubah`,
                              time: new Date(),
                              status: "unread",
                              updated_by: "System",
                              metadata: {
                                    previous_schedule: prevSchedule,
                                    new_schedule: newSchedule
                              },
                        });
                  }
            }

            // Perbarui nilai sebelumnya
            previousValues[pondId].feeding_schedule = newSchedule;
      }

      // 🔹 Notifikasi Perubahan Kontrol Aerator (aerator_control_update)
      if (pondData.device_config && pondData.device_config.aerator) {
            const newAerator = pondData.device_config.aerator.aerator_delay;
            const prevAerator = previousValues[pondId].aerator_delay;

            if (prevAerator !== undefined && newAerator !== undefined && prevAerator !== newAerator) {
                  if (!(await isDuplicateNotification(pondId, "aerator_control_update"))) {
                        console.log(`💨 Aerator control updated for ${namePond}`);

                        await createNotification({
                              idPond: pondId,
                              type: "aerator_control_update",
                              title: "Pengaturan Aerator Diperbarui",
                              message: `Pengaturan aerator untuk kolam ${namePond} telah diperbarui`,
                              time: new Date(),
                              status: "unread",
                              updated_by: "System",
                              metadata: {
                                    previous_aerator_control: prevAerator,
                                    new_aerator_control: newAerator
                              },
                        });
                  }
            }

            // Perbarui nilai sebelumnya
            previousValues[pondId].aerator_delay = newAerator;
      }
});

console.log("🔄 Firebase notification listener aktif...");