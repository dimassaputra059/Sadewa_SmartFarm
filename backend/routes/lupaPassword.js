const express = require("express");
const {
	sendOTP,
	verifyOTP
} = require("../services/lupaPassword");

const router = express.Router();

router.post("/send-otp", async (req, res) => {
	const {
		email
	} = req.body;
	try {
		const message = await sendOTP(email);
		res.json({
			message
		});
	} catch (error) {
		res.status(400).json({
			message: error.message
		});
	}
});

router.post("/verify-otp", (req, res) => {
	const {
		email,
		otp
	} = req.body;
	try {
		const token = verifyOTP(email, otp);
		res.json({
			message: "OTP valid, lanjutkan reset password!",
			token
		});
	} catch (error) {
		res.status(400).json({
			message: error.message
		});
	}
});

module.exports = router;