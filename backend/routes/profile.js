const express = require("express");
const {
	getProfile,
	updateProfile
} = require("../services/profile");

const router = express.Router();

// ✅ Ambil profil user
router.get("/profile", async (req, res) => {
	try {
		const authHeader = req.headers.authorization;
		const token = authHeader && authHeader.split(" ")[1];

		const user = await getProfile(token);
		res.json(user);
	} catch (error) {
		res.status(401).json({
			message: error.message
		});
	}
});

// ✅ Edit profil user
router.put("/profile", async (req, res) => {
	try {
		const authHeader = req.headers.authorization;
		const token = authHeader && authHeader.split(" ")[1];

		const {
			username,
			email
		} = req.body;
		const result = await updateProfile(token, {
			username,
			email
		});
		res.json(result);
	} catch (error) {
		res.status(401).json({
			message: error.message
		});
	}
});

module.exports = router;