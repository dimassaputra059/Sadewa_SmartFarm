// services/kolamService.js
const Kolam = require("../models/kolam");

module.exports = {
      getAllKolam: async () => {
            try {
                  const kolam = await Kolam.find();
                  return {
                        status: 200,
                        success: true,
                        data: kolam
                  };
            } catch (error) {
                  return {
                        status: 500,
                        success: false,
                        message: error.message
                  };
            }
      },
      createKolam: async (data) => {
            try {
                  const kolam = new Kolam(data);
                  await kolam.save();
                  return {
                        status: 201,
                        success: true,
                        message: "Kolam berhasil ditambahkan",
                        data: kolam
                  };
            } catch (error) {
                  return {
                        status: 500,
                        success: false,
                        message: error.message
                  };
            }
      },
      updateKolam: async (id, data) => {
            try {
                  const kolam = await Kolam.findByIdAndUpdate(id, data, {
                        new: true
                  });
                  if (!kolam) return {
                        status: 404,
                        success: false,
                        message: "Kolam tidak ditemukan"
                  };
                  return {
                        status: 200,
                        success: true,
                        message: "Kolam berhasil diperbarui",
                        data: kolam
                  };
            } catch (error) {
                  return {
                        status: 500,
                        success: false,
                        message: error.message
                  };
            }
      },
      deleteKolam: async (id) => {
            try {
                  const kolam = await Kolam.findByIdAndDelete(id);
                  if (!kolam) return {
                        status: 404,
                        success: false,
                        message: "Kolam tidak ditemukan"
                  };
                  return {
                        status: 200,
                        success: true,
                        message: "Kolam berhasil dihapus"
                  };
            } catch (error) {
                  return {
                        status: 500,
                        success: false,
                        message: error.message
                  };
            }
      }
};