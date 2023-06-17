const prisma = require('../prisma/dbConnection');
// Controller function to get all restaurants
const getAllRestaurants = async (req, res) => {
	try {
		const idUser = Number(req.params.idUser);
		let restaurants = [];

		if (!idUser) {
			// Fetch all restaurants
			restaurants = await prisma.restaurants.findMany();
		} else {
			// Fetch preferred restaurants for the user
			const preferredRestaurants =
				await prisma.prefer_restaurant.findMany({
					where: {
						user_id: idUser,
					},
					select: {
						restaurant_id: true,
					},
				});

			// Get the IDs of the preferred restaurants
			const preferredRestaurantIds = preferredRestaurants.map(
				(restaurant) => restaurant.restaurant_id
			);

			// Fetch all restaurants and mark them as preferred or not
			restaurants = await prisma.restaurants.findMany();

			// Add a new attribute indicating if the restaurant is preferred by the user
			restaurants = restaurants.map((restaurant) => ({
				...restaurant,
				isPreferred: preferredRestaurantIds.includes(restaurant.id),
			}));
		}

		res.status(200).json(restaurants);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

const getFavriteRestaurants = async (req, res) => {
	try {
		const idUser = Number(req.params.idUser);

		// Fetch preferred restaurant IDs for the user
		const preferredRestaurantIds =
			await prisma.prefer_restaurant.findMany({
				where: {
					user_id: idUser,
				},
				select: {
					restaurant_id: true,
				},
			});

		// Extract the restaurant IDs from the fetched results
		const restaurantIds = preferredRestaurantIds.map(
			(item) => item.restaurant_id
		);

		// Fetch restaurant details for the extracted IDs
		let preferredRestaurants = await prisma.restaurants.findMany({
			where: {
				id: {
					in: restaurantIds,
				},
			},
		});
		preferredRestaurants = preferredRestaurants.map((restaurant) => ({
			...restaurant,
			isPreferred: true,
		}));

		res.status(200).json(preferredRestaurants);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

// Controller function to get a specific restaurant by ID
const getRestaurantById = async (req, res) => {
	try {
		const { id } = req.params;
		const restaurant = await prisma.restaurants.findUnique({
			where: {
				id: Number(id),
			},
		});

		if (!restaurant) {
			// Handle the case when the restaurant doesn't exist
			return res.status(404).json({ error: 'Restaurant not found' });
		}

		const menuitems = await prisma.menuitems.findMany({
			where: {
				restaurant_id: Number(id),
			},
		});

		const restaurantWithMenu = {
			...restaurant,
			menuitems: menuitems,
		};

		res.status(200).json(restaurantWithMenu);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

// Controller function to get a specific restaurant Menu by ID
const getRestaurantMenuById = async (req, res) => {
	try {
		const { id } = req.params;
		const restaurant = await prisma.menuitems.findMany({
			where: { restaurant_id: parseInt(id) },
		});
		if (!restaurant) {
			return res
				.status(404)
				.json({ error: `Restaurant with ID ${id} not found` });
		}
		return res.status(200).json(restaurant);
	} catch (err) {
		res.status(500).json({ error: err.message });
	}
};

module.exports = {
	getAllRestaurants,
	getRestaurantById,
	getRestaurantMenuById,
	getFavriteRestaurants,
};
