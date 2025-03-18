const User = require("../models/users");
const jwt = require("jsonwebtoken");

const SECRET_KEY = process.env.JWT_SECRET;

const getProfile = async (token) => {
      if (!token) {
            throw new Error("Unauthorized");
      }

      // Verifikasi token JWT
      const decoded = jwt.verify(token, SECRET_KEY);
      const user = await User.findById(decoded.id).select("-password"); // Jangan kirim password

      if (!user) {
            throw new Error("User tidak ditemukan");
      }

      return user;
};

const updateProfile = async (token, {
      username,
      email
}) => {
      if (!token) {
            throw new Error("Unauthorized");
      }

      const decoded = jwt.verify(token, SECRET_KEY);
      const user = await User.findById(decoded.id);

      if (!user) {
            throw new Error("User tidak ditemukan");
      }

      // Perbarui data user
      user.username = username || user.username;
      user.email = email || user.email;
      await user.save();

      return {
            message: "Profil berhasil diperbarui",
            user
      };
};

module.exports = {
      getProfile,
      updateProfile,
};