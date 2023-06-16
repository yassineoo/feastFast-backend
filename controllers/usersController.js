const { hash } = require('bcrypt');
const prisma = require('../prisma/dbConnection');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { IncomingForm } = require('formidable');
const fs = require('fs');
const path = require('path');
// Create a new User
async function sighUp(req, res) {
	try {
		console.log('hiii');
		console.log(req.body);
		console.log(req.body.image?.headers);
		const form = new IncomingForm({
			multiples: false,
			keepExtensions: true,
			uploadDir: process.env.UPLOAD_DIR,
			type: 'multipart',
			parse: (req, options, callback) => {
				// use the default parser
				return IncomingForm.prototype.parse.call(
					this,
					req,
					options,
					callback
				);
			},
		});

		form.parse(req, async (err, fields, files) => {
			console.log('parse function called !!');
			if (err) {
				console.error(err);
				throw err;
			}

			let { ...data } = fields; // destructure the fields
			console.log(files.image);
			console.log(`fields`);
			console.log(fields);
			const image = files.image?.filepath; // get the path to the image file
			hashedPassword = await bcrypt.hash(req.body.password, 10);

			const uploadsPath = path.join(__dirname, '..', 'public');
			console.log(uploadsPath);
			if (!fs.existsSync(uploadsPath)) {
				fs.mkdirSync(uploadsPath);
			}
			console.log('saving the image ....');
			// save the image to disk
			if (image) {
				const imageName = `profile${Math.random()}.png`; // use the advertiser ID as the image name
				const imagePath = path.join(uploadsPath, imageName); // specify the path to save the image

				await fs.promises.rename(image, imagePath);
				console.log(imageName);

				data = {
					...fields,
					password: hashedPassword,
					image: imageName,
				};
				const result = await prisma.users.create({
					data,
				});
				console.log('result :', result);
				return res.status(200).json(result);
			}
		});
		console.log('ended');
	} catch (error) {
		console.error(error);
		res.json({ secsus: false, message: error.message });
	}
}

// Read a User by id
const getUserById = async (req, res) => {
	try {
		const { id } = req.params;
		const result = await prisma.users.findUnique({
			where: { id: Number(id) },
		});
		return res.status(200).json(result);
	} catch (error) {
		console.error(error);
		// throw new Error('Error getting User by id');
	}
};

// Update a User
const updateUser = async (req, res) => {
	try {
		const id = req.body.id;
		console.log(id);
		data = req.body;
		if (data.password) {
			data.password = await bcrypt.hash(data.password, 10);
		}
		//console.log(data);

		const result = await prisma.users.update({
			where: { id: Number(id) },
			data: { ...req.body },
		});
		return result;
	} catch (error) {
		console.error(error);
		throw new Error('Error updating User');
	}
};

//  Login :

const login = async (req, res) => {
	const { email, password } = req.body;
	console.log(`req.body \n`);
	console.log(req.body);
	try {
		const user = await prisma.users.findUnique({ where: { email } });
		if (!user) {
			return res.status(404).json({ message: "Email doesn't exist" });
		}

		const passCorrect = await bcrypt.compare(password, user.password);
		if (!passCorrect) {
			return res
				.status(400)
				.json({ message: 'Wrong password, try again' });
		}

		const token = jwt.sign({ email, id: user.id }, 'secret_key', {
			expiresIn: '5h',
		});

		//	res.status(200).json({ result: user, token });
		res.status(200).json(user);
	} catch (error) {
		res.status(500).json(error);
	}
};

// favorite Restaurant : like if it doesnt exist and unlike if it existe
const favoriteRestaurant = async (req, res) => {
	try {
		const { iduser, idres } = req.params;

		// Check if the restaurant is already favorited by the user
		const isFavorite = await checkIfRestaurantIsFavorite(iduser, idres);

		if (isFavorite) {
			// If the restaurant is already favorited, unlike it
			await unlikeRestaurant(iduser, idres);
			return res
				.status(200)
				.json({ message: 'Restaurant unliked successfully' });
		} else {
			// If the restaurant is not favorited, like it
			await likeRestaurant(iduser, idres);
			return res
				.status(200)
				.json({ message: 'Restaurant liked successfully' });
		}
	} catch (error) {
		console.error(error);
		throw new Error('Error updating User');
	}
};

// Function to check if the restaurant is already favorited
const checkIfRestaurantIsFavorite = async (userId, restaurantId) => {
	const favorite = await prisma.prefer_restaurant.findFirst({
		where: {
			user_id: Number(userId),
			restaurant_id: Number(restaurantId),
		},
	});

	return favorite !== null;
};

// Function to unlike the restaurant
const unlikeRestaurant = async (userId, restaurantId) => {
	await prisma.prefer_restaurant.deleteMany({
		where: {
			user_id: Number(userId),
			restaurant_id: Number(restaurantId),
		},
	});
};

// Function to like the restaurant
const likeRestaurant = async (userId, restaurantId) => {
	await prisma.prefer_restaurant.create({
		data: {
			user_id: Number(userId),
			restaurant_id: Number(restaurantId),
		},
	});
};

// Delete a User
const deleteUser = async (req, res) => {
	try {
		const { id } = req.params;
		const result = await prisma.users.delete({
			where: { id: Number(id) },
		});
		return result;
	} catch (error) {
		console.error(error);
		throw new Error('Error deleting User');
	}
};

module.exports = {
	login,
	sighUp,
	getUserById,
	updateUser,
	deleteUser,
	favoriteRestaurant,
};
