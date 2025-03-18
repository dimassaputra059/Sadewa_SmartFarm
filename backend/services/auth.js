const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require("../models/users");
const admin = require("firebase-admin");
const dotenv = require("dotenv");
dotenv.config();

const SECRET_KEY = process.env.JWT_SECRET;

const AuthService = {
      // ✅ Login User
      login: async (username, password) => {
            const user = await User.findOne({
                  username
            });
            if (!user) throw new Error("User tidak ditemukan!");

            const isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch) throw new Error("Password salah!");

            const token = jwt.sign({
                        id: user._id,
                        username: user.username,
                        role: user.role
                  },
                  SECRET_KEY, {
                        expiresIn: "1h"
                  }
            );

            // ✅ Subscribe ke topic global (tanpa perlu deviceToken)
            await admin.messaging().subscribeToTopic([token], "global_notifications");
            console.log(`✅ User ${username} berhasil subscribe ke global_notifications`);

            return {
                  message: "Login berhasil!",
                  token
            };
      },

      // ✅ Logout User (Frontend menghapus token)
      logout: async (token) => {
            if (!token) throw new Error("Token tidak ditemukan!");

            try {
                  // ✅ Unsubscribe dari topic global
                  await admin.messaging().unsubscribeFromTopic([token], "global_notifications");
                  console.log(`🚫 User dengan token ${token} berhasil unsubscribe dari global_notifications`);
            } catch (error) {
                  console.error(`❌ Gagal unsubscribe dari global_notifications: ${error.message}`);
            }

            return {
                  message: "Logout berhasil!"
            };
      }
};

module.exports = AuthService;