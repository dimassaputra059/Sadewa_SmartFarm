const User = require("../models/users");
const mongoose = require("mongoose");

const getAllUsers = async () => {
      return await User.find({}, "id username email role createdAt");
};

const deleteUserById = async (id) => {
      if (!mongoose.Types.ObjectId.isValid(id)) {
            throw new Error("ID tidak valid");
      }

      const user = await User.findById(id);
      if (!user) {
            throw new Error("User tidak ditemukan");
      }

      console.log(`Menghapus user: ${user.username}`);
      await User.findByIdAndDelete(id);
      return user.username;
};

const updateUserById = async (id, {
      username,
      email,
      role
}) => {
      if (!mongoose.Types.ObjectId.isValid(id)) {
            throw new Error("ID tidak valid");
      }

      const user = await User.findById(id);
      if (!user) {
            throw new Error("User tidak ditemukan");
      }

      user.username = username;
      user.email = email;
      user.role = role;
      await user.save();

      console.log(`User ${user.username} berhasil diperbarui`);
      return user;
};

const createUser = async ({
      username,
      email,
      password,
      role
}) => {
      if (!username || !email || !password || !role) {
            throw new Error("Semua field harus diisi!");
      }

      const existingUser = await User.findOne({
            email
      });
      if (existingUser) {
            throw new Error("Email sudah digunakan!");
      }

      const newUser = new User({
            username,
            email,
            password,
            role
      });
      await newUser.save();

      return newUser;
};

module.exports = {
      getAllUsers,
      deleteUserById,
      updateUserById,
      createUser
};