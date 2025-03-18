const {
	db
} = require("../config/firebaseConfig");
const History = require("../models/history");
const cron = require("node-cron");

const dailyHistoryBuffer = {};

const getHistoryByPond = async (idPond) => {
	try {
		// Ambil semua riwayat berdasarkan idPond
		const history = await History.find({
			idPond
		}).sort({
			date: -1
		}); // Urutkan dari terbaru

		return history.length > 0 ? history : null;
	} catch (error) {
		console.error("❌ Gagal mengambil riwayat:", error.message);
		throw new Error("Gagal mengambil data riwayat.");
	}
};

// ✅ Fungsi untuk mengambil riwayat berdasarkan _id MongoDB
const getHistoryById = async (id) => {
	try {
		const history = await History.findById(id);
		return history || null;
	} catch (error) {
		console.error("❌ Gagal mengambil riwayat berdasarkan ID:", error.message);
		throw new Error("Gagal mengambil data riwayat berdasarkan ID.");
	}
};

// ✅ Fungsi untuk mengambil data dari Firebase setiap 15 menit
const collectDataFromFirebase = async () => {
	try {
		console.log("🔄 Mengambil data monitoring dari Firebase...");

		const ref = db.ref("Sadewa_SmartFarm/ponds");
		const snapshot = await ref.once("value");
		const pondsData = snapshot.val();

		if (!pondsData) {
			console.log("⚠️ Tidak ada data kolam ditemukan.");
			return;
		}

		const time = new Date().toLocaleTimeString("id-ID", {
			hour12: false
		});
		const date = new Date().toISOString().split("T")[0];

		for (const pondId in pondsData) {
			const pond = pondsData[pondId];

			if (!pond.sensor_data) continue;

			// ✅ Hanya mengambil data sensor yang diperlukan
			const {
				temperature,
				pH,
				salinity,
				turbidity,
				rain_status
			} = pond.sensor_data;

			const historyData = {
				time,
				temperature,
				pH,
				salinity,
				turbidity,
				rain_status, // ✅ Menyimpan status hujan
			};

			// Simpan ke buffer sementara
			if (!dailyHistoryBuffer[pondId]) {
				dailyHistoryBuffer[pondId] = {};
			}
			if (!dailyHistoryBuffer[pondId][date]) {
				dailyHistoryBuffer[pondId][date] = [];
			}

			dailyHistoryBuffer[pondId][date].push(historyData);
			console.log(`✅ Data ditambahkan ke buffer untuk ${pondId} pada ${time}`);
		}
	} catch (error) {
		console.error("❌ Gagal mengambil data dari Firebase:", error.message);
	}
};

// ✅ Fungsi untuk menyimpan laporan harian ke MongoDB
const saveDailyHistory = async () => {
	try {
		console.log("📁 Menyimpan laporan harian ke database...");

		const date = new Date().toISOString().split("T")[0];

		for (const pondId in dailyHistoryBuffer) {
			if (!dailyHistoryBuffer[pondId][date]) continue;

			try {
				const newHistory = new History({
					idPond: pondId,
					date,
					data: dailyHistoryBuffer[pondId][date],
				});
				await newHistory.save();
				console.log(`✅ Laporan harian untuk ${pondId} pada ${date} berhasil disimpan.`);
			} catch (error) {
				console.log(`⚠️ Tidak dapat menyimpan laporan untuk ${pondId}: ${error.message}`);
			}
		}

		// Reset buffer setelah data disimpan
		delete dailyHistoryBuffer[date];
	} catch (error) {
		console.error("❌ Gagal menyimpan laporan harian:", error.message);
	}
};

const deleteOldHistory = async () => {
	try {
		const oneMonthAgo = new Date();
		oneMonthAgo.setMonth(oneMonthAgo.getMonth() - 1);

		console.log("🗑️ Menghapus riwayat lebih dari 1 bulan...");

		const result = await History.deleteMany({
			created_at: {
				$lt: oneMonthAgo
			} // Gunakan `created_at`, bukan `date`
		});
		console.log(`✅ Riwayat lama yang dihapus: ${result.deletedCount}`);
	} catch (error) {
		console.error("❌ Gagal menghapus riwayat lama:", error.message);
	}
};

// ✅ Cron job untuk mengambil data dari Firebase setiap 15 menit
cron.schedule("*/15 * * * *", async () => {
	console.log("⏳ Mengambil data setiap 15 menit...");
	await collectDataFromFirebase();
}, {
	scheduled: true,
	timezone: "Asia/Jakarta",
});

// ✅ Cron job untuk menyimpan laporan harian ke MongoDB setiap tengah malam
cron.schedule("0 0 * * *", async () => {
	console.log("⏳ Menyimpan laporan harian...");
	await saveDailyHistory();
}, {
	scheduled: true,
	timezone: "Asia/Jakarta",
});

// ✅ Cron job untuk menghapus riwayat lebih dari 1 bulan setiap tengah malam
cron.schedule("0 0 * * *", async () => {
	console.log("⏳ Menghapus riwayat lama...");
	await deleteOldHistory();
}, {
	scheduled: true,
	timezone: "Asia/Jakarta",
});

module.exports = {
	getHistoryByPond,
	getHistoryById
};